import colors from 'colors';

export default {
  program_name: "snarkdb".green.bold,
  usage_description: "Usage:".yellow.bold,
  args_pattern: "<COMMAND> [OPTIONS]",
  description: "snarkDB is a tool for exposing any RDBMS to zero knowledge SQL queries.",
  optional_args: [
    {
      name: "mnemonic",
      description: "Mnemonic seed phrase of your snarkDB account.",
      type: "string",
    },
    {
      name: "verbosity",
      description: "Verbosity level: 0, 1 (default), 2.",
      type: "number",
    },
  ]
};