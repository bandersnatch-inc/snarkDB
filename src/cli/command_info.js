import colors from 'colors';

export default {
  program_name: "snarkdb".green.bold,
  usage_description: "Usage:".yellow.bold,
  args_pattern: "<COMMAND> [OPTIONS]",
  description: "snarkDB is a tool for exposing your RDBMS to zero knowledge SQL queries.",
  optional_args: [
    {
      name: "privateKey",
      description: "Aleo private key used for signature.",
      type: "string",
    },
    {
      name: "verbosity",
      description: "Verbosity level: 0, 1 (default), 2.",
      type: "number",
    },
  ]
};