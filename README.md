# KindleForge

**Books, prepared for reading.** KindleForge is a local-first Linux desktop library that turns readable PDFs into metadata-rich EPUB and AZW3 files for Kindle sideloading. It keeps the original PDF and every generated format on your machine.

![KindleForge library](assets/screenshot.svg)

## Install on Arch Linux

```bash
curl -fsSL https://raw.githubusercontent.com/lucasonline0/KindleForge/main/install.sh | bash
```

The installer downloads a verified release package, installs `calibre` and `poppler` when `pacman` is available, and installs the `kindleforge` command. Other Linux distributions receive the AppImage.

## What it does

- Imports several PDFs through the picker or drag-and-drop queue.
- Validates PDF signatures, size, file type and parseability before processing.
- Identifies title and author from PDF metadata, filename and Open Library.
- Caches covers and metadata locally; browsing remains offline after import.
- Detects scanned/no-text PDFs rather than producing a silently broken ebook.
- Uses Calibre's `ebook-convert` with separate process arguments to generate EPUB and AZW3.
- Stores a persistent SQLite catalogue at `~/Documents/KindleForge/Library`.

## Formats and requirements

Input is PDF. Output is EPUB and AZW3. KindleForge requires Calibre (`ebook-convert`) and Poppler; the Arch package and installer declare/install both. No Node.js or npm is needed on an installed machine.

## Development

```bash
npm ci
npm run dev
npm test
npm run build
```

## Architecture

`src/main` owns the filesystem, SQLite, metadata lookup and conversion. `src/preload` exposes a deliberately small IPC bridge. `src/renderer` is a React desktop UI with no Node access. Shared, serializable models sit in `src/shared`.

## Security

Electron runs with `nodeIntegration: false`, context isolation, and a sandboxed renderer. IPC validates payloads; library paths are contained and file names are sanitized. PDFs are treated as untrusted input; conversion uses `spawn` with argument arrays, explicit timeout, and no shell.

## License

[MIT](LICENSE)
