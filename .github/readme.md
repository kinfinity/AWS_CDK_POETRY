# AWS_CDK_POETRY

![cdk logo](../assets/images/cdk-logo.png)

The **AWS CDK Poetry** project aims to automate the generation of AWS CDK (Cloud Development Kit) projects managed with Python Poetry. This documentation provides an overview of the project, its goals, and instructions for setting up and using the automated project generation process.

## [![Generated Projects Build](https://github.com/kinfinity/AWS_CDK_POETRY/actions/workflows/projects-build.yml/badge.svg)](https://github.com/kinfinity/AWS_CDK_POETRY/actions/workflows/projects-build.yml)[![CLI Build 2 Release](https://github.com/kinfinity/AWS_CDK_POETRY/actions/workflows/cli-build_release.yml/badge.svg)](https://github.com/kinfinity/AWS_CDK_POETRY/actions/workflows/cli-build_release.yml) [![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org/)

## Table of Contents

- [Introduction](##introduction)
- [Getting Started](##Getting-started)
  - [Prerequisites](###Prerequisites)
  - [Installation](###Installation)
- [Usage](##usage)
  - [Using Makefile](##using-makefile)
- [Contributing](###contributing)
- [License](##license)

---

## Introduction

The AWS CDK Poetry project simplifies the process of creating AWS CDK projects while leveraging the Python Poetry package manager. AWS CDK allows you to define cloud infrastructure using familiar programming languages. By combining this power with Poetry's dependency management, you can quickly and efficiently create CDK projects with the necessary dependencies.

---

## Getting Started

### Prerequisites

Before using AWS CDK Poetry, ensure you have the following prerequisites installed:

- WSL 2 - Ubuntu 22.04.2 LTS

### Installation

Clone the **AWS C**

**DK Poetry** repository:

```
git clone https://github.com/kinfinity/aws-cdk-poetry.git
```

Navigate to the project directory:

```
cd aws-cdk-poetry
```

---

## Usage

### Project Generation - Makefile

The **AWS CDK Poetry** project provides a `Makefile` that simplifies the setup process for generating projects and cleaning up generated files. To create a new AWS CDK project using Poetry, follow these steps & Replace `<project-name>` with the desired name for your project:

- Open a terminal in your WSL 2 Ubuntu environment.
- Navigate to the directory containing the `Makefile` and your scripts.
- Run the following command to set up the project:
- Replace `<project-name>` with your desired project name.

```
make setup PROJECT_NAME=<project-name> SETUP_REQUIREMENTS=yes
```

To clean up any generated files from the project, use the following command:

```
make clean
```

Running this command will execute the cleanup functions to remove temporary and unnecessary files.

---

## Contributing

We welcome contributions to the **AWS CDK Poetry** project! If you have ideas for improvements or find any issues, please feel free to submit pull requests or open issues on the project repository.

---

## License

This project is licensed under the The Unlicense.

---

**AWS CDK Poetry** is maintained by [Egbewatt Kokou](https://github.com/kinfinity) . We appreciate your interest and hope this tool simplifies your AWS CDK project setup process. Happy coding!
