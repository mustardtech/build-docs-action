[![Integration Test](https://github.com/mustardtech/build-docs-action/actions/workflows/integration.yaml/badge.svg)](https://github.com/mustardtech/build-docs-action/actions/workflows/integration.yaml)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](https://github.com/mustardtech/build-docs-action/blob/main/LICENSE)


# build-docs-action
A Github action that builds markdown documents from a source folder recursively with pandoc, supports mermaid syntax via mermaid-filter


---

## Inputs

| name    | required | type   | default                     | description                                                    |
|---------|----------|--------|-----------------------------|----------------------------------------------------------------|
| path    | no       | string | `"docs"`                    | Source path directory to build all `*.md` docs within          |
| output  | no       | string | `"output"`                  | The output directory for the generated documents               |
| format  | no       | string | `"docx"`                    | Pandoc output document format.                                 |
| filters | no       | string | `"--filter=mermaid-filter"` | Filters for Pandoc to use (currently only support for mermaid) |


## Outputs

This action create a folder from the `output` input with the rendered documents which can then be uploaded to an artifact

---


## Example usage

Workflow:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    name: Build docs
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - uses: mustardtech/build-docs-action@dev

      - name: Upload docx Artifacts
        uses: actions/upload-artifact@v4
        with:
          name: docs
          path: output
          retention-days: 1
```
