# uim-datamodel

## Overview

The `uim-datamodel` project is a library designed for working with common data models in the D programming language. It provides a comprehensive set of functionalities for defining, validating, serializing, and deserializing data models, as well as handling various data formats.

## Features

- **Core Data Model**: Define and manipulate data models with properties and methods.
- **Field Types**: Support for various field types with validation rules.
- **Input/Output Handling**: Read and write data from/to multiple formats including JSON, XML, YAML, CSV, and TOML.
- **Serialization**: Serialize data models into different formats and deserialize data from those formats.
- **Querying**: Build and apply queries against data models with filters.
- **Adapters**: Integrate with external systems such as databases and REST APIs.

## Installation

To use the `uim-datamodel` library, you can include it in your DUB project by adding the following dependency to your `dub.json` file:

```json
"dependencies": {
    "uim-datamodel": "~>0.1.0"
}
```

## Usage

### Basic Example

Here is a simple example of how to use the `uim-datamodel` library:

```d
import datamodel.core.model;

void main() {
    auto myModel = new MyModel();
    // Manipulate your data model here
}
```

### Custom Format Example

To use a custom format, you can refer to the `examples/custom_format.d` file for guidance on how to implement it.

## Testing

The project includes unit tests to ensure the functionality of core components, format handling, and serialization. You can run the tests using the following command:

```bash
dub test
```

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests to improve the library.

## License

This project is licensed under the Apache 2.0 License. See the LICENSE.txt file for more details.