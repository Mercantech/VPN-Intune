# Undervisning: Git vs. OneDrive

Dette repo indeholder både en rigtig FortiClient/PSADT-deployment-pakke og **demomateriale**, der viser hvorfor Git er bedre end OneDrive til scripts og konfiguration.

## Materiale

| Dokument | Indhold |
|----------|---------|
| [Fra OneDrive til Git](../Fra-OneDrive-til-Git.md) | Teori, diagrammer og arbejdsgang |
| [commit-oversigt.md](commit-oversigt.md) | Hvilken commit illustrerer hvad + kommandoer til sessionen |

## Demofiler

Fiktive filer under `examples/git-demo/` bruges **kun** til undervisning. De påvirker ikke `Invoke-AppDeployToolkit.ps1`.

## Sådan bruger du den forberedte historik

Historikken er bygget op som **9 små commits** på `main`. Under sessionen kører du typisk:

```powershell
git log --oneline --graph
```

Gå derefter commit for commit med `git show <hash>` som beskrevet i [commit-oversigt.md](commit-oversigt.md).

*netIP · undervisningsmateriale*
