import js from '@eslint/js';
import parser from '@typescript-eslint/parser';
import plugin from '@typescript-eslint/eslint-plugin';
export default [
  { ignores: ['dist/**', 'node_modules/**'] },
  js.configs.recommended,
  { files: ['**/*.{ts,tsx}'], languageOptions: { parser, globals: { window: 'readonly', document: 'readonly', File: 'readonly', process: 'readonly', __dirname: 'readonly', Buffer: 'readonly', fetch: 'readonly', AbortController: 'readonly', setTimeout: 'readonly', clearTimeout: 'readonly' } }, plugins: { '@typescript-eslint': plugin }, rules: { ...plugin.configs.recommended.rules, '@typescript-eslint/no-explicit-any': 'off', 'no-control-regex': 'off', 'no-useless-escape': 'off', '@typescript-eslint/no-unused-expressions': 'off' } }
];
