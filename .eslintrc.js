module.exports = {
  root: true,
  extends: ['prettier'],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  overrides: [
    {
      files: ['*.ts', '*.tsx', '*.mts'],
      rules: {
        '@typescript-eslint/no-shadow': 'off',
        'no-shadow': 'off',
        'no-undef': 'off',
        curly: 'off',
      },
    },
  ],
};
