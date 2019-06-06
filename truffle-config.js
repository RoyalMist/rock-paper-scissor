const path = require("path");

module.exports = {
    compilers: {
        solc: {
            version: "0.5.9"
        }
    },
    contracts_build_directory: path.join(__dirname, "app/src/contracts"),
    networks: {
        development: {
            host: "127.0.0.1",
            port: 8545,
            network_id: "*"
        }
    }
};
