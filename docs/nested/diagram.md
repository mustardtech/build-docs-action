# Diagram

```mermaid
sequenceDiagram
    participant Code
    participant Action
    participant Pandoc

    Code->>Action:Initiate build docs action
    Action->>Pandoc:Pass file to convert to
    Pandoc->>Action:Upload files to artifacts
    Action->>Code:Send artifact links
```
