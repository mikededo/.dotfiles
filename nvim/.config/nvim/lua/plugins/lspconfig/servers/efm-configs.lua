-- The efm-configs-nvim plugin is quite heavy and slows the startup enough for
-- me to be noticeable. That's why I've opted to copy the configurations that
-- are only required in my case, instead of importing everything. All credits
-- to the author of the plugin

---@alias ScopeType
---| 'BUNDLE'
---| 'COMPOSER'
---| 'NODE'

local Scope = { NODE = 'NODE', COMPOSER = 'COMPOSER', BUNDLE = 'BUNDLE' }
local FilepathByScope = {
  NODE = 'node_modules/.bin',
  COMPOSER = 'vendor/bin',
  BUNDLE = 'vendor/bundle',
}

---Get local executable based on scope, if present.
---@param binary string
---@param context string
---@return string
local function local_executable(binary, context)
  local relativepath = FilepathByScope[context]
  local binarypath =
    string.format('%s/%s/%s', vim.loop.cwd(), relativepath, binary)

  if vim.fn.filereadable(binarypath) == 0 then
    error(
      string.format(
        '%q: No local executable found, check |efmls-configs-issues| for help',
        binary
      ),
      0
    )
  end

  return binarypath
end

---Get global executable, if present.
---@param binary string
---@return string
local function global_executable(binary)
  if vim.fn.executable(binary) == 0 then
    error(
      string.format(
        '%q: No global executable found, check |efmls-configs-issues| for help',
        binary
      ),
      0
    )
  end

  return vim.fn.exepath(binary)
end

---Get binary path, first from project-local then from
---global paths otherwise. Report to :checkhealth if
---found or not.
---@param name string
---@param context? ScopeType
local function executable(name, context)
  -- Track linter/formatter status
  if _G._efmls == nil then
    _G._efmls = { healthcheck = { errors = {}, ok = {} } }
  end

  local local_ok, local_binarypath, global_ok, global_binarypath

  if context then
    -- get info from local path
    local_ok, local_binarypath = pcall(local_executable, name, context)
  end

  -- if that fails then get from global
  global_ok, global_binarypath = pcall(global_executable, name)

  if not global_ok and not local_ok then
    local reason = local_binarypath
    table.insert(_G._efmls.healthcheck.errors, reason)

    reason = global_binarypath
    table.insert(_G._efmls.healthcheck.errors, reason)

    return name
  end

  if local_ok then
    table.insert(
      _G._efmls.healthcheck.ok,
      string.format('%q: Found at %s', name, local_binarypath)
    )

    return local_binarypath
  end

  table.insert(
    _G._efmls.healthcheck.ok,
    string.format('%q: Found at %s', name, global_binarypath)
  )

  return global_binarypath
end

local function sourceText(suffix)
  return string.format('efm/%s', suffix)
end

-- Config definitions
return {
  actionlint = {
    prefix = 'actionlint',
    lintSource = sourceText('actionlint'),
    lintCommand = string.format(
      '%s -no-color -oneline -stdin-filename "${INPUT}" -',
      executable('actionlint')
    ),
    lintStdin = true,
    lintFormats = {
      '%f:%l:%c: %.%#: SC%n:%trror:%m',
      '%f:%l:%c: %.%#: SC%n:%tarning:%m',
      '%f:%l:%c: %.%#: SC%n:%tnfo:%m',
      '%f:%l:%c: %m',
    },
    requireMarker = true,
    rootMarkers = { '.github/' },
  },
  eslint = {
    formatCommand = string.format(
      '%s %s',
      executable('eslint_d', Scope.NODE),
      '--fix-to-stdout --stdin-filename \'${INPUT}\' --stdin'
    ),
    formatStdin = true,
    requireMarker = true,
    rootMarkers = {
      '.eslintrc',
      '.eslintrc.js',
      'eslint.config.js',
      'eslint.config.ts',
      'eslint.config.cjs',
      'eslint.config.cts',
      'eslint.config.mjs',
      'eslint.config.mts',
    },
  },
  prettier = {
    formatCanRange = true,
    formatCommand = string.format(
      '%s \'${INPUT}\' ${--range-start=charStart} ${--range-end=charEnd} '
        .. '${--tab-width=tabWidth} ${--use-tabs=!insertSpaces}',
      executable('prettierd', Scope.NODE)
    ),
    formatStdin = true,
    requireMarker = true,
    rootMarkers = {
      '.prettierrc',
      '.prettierrc.json',
      '.prettierrc.js',
      '.prettierrc.yml',
      '.prettierrc.yaml',
      '.prettierrc.json5',
      '.prettierrc.mjs',
      '.prettierrc.cjs',
      '.prettierrc.toml',
      'prettier.config.js',
      'prettier.config.cjs',
      'prettier.config.mjs',
    },
  },
  lua = {
    formatCanRange = true,
    formatCommand = string.format(
      '%s --color Never ${--range-start:charStart} ${--range-end:charEnd} --stdin-filepath \'${INPUT}\' -',
      executable('stylua')
    ),
    formatStdin = true,
    requireMarker = true,
    rootMarkers = { 'stylua.toml', '.stylua.toml' },
  },
}
