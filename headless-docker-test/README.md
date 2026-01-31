# Chezmoi Installation Testing

Test harness to verify headless server installations don't pull in GUI packages.

## Quick Start

```bash
cd test/
./run-test.sh
```

## What It Does

1. **Builds** minimal Ubuntu 24.04 container with chezmoi
2. **Mounts** your chezmoi repo (read-only)
3. **Wraps** apt-get to log all installations
4. **Runs** `chezmoi init` and `chezmoi apply`
5. **Reports** what packages were installed
6. **Flags** any GUI/X11 packages detected

## Expected Output

### Good (Headless)
```
✓ No obvious GUI packages detected
Total packages: ~150
```

### Bad (GUI Installed)
```
⚠️  WARNING: GUI packages detected:
- sway
- libwayland-client0
- libx11-6
- xorg-sgml-doctools
[... more packages ...]
Total packages: ~400+
```

## Files

- `Dockerfile` - Container definition
- `test-install.sh` - Installation test script (runs in container)
- `run-test.sh` - Test orchestrator (run this)

## Troubleshooting

**Docker not found:**
```bash
sudo apt install docker.io
sudo usermod -aG docker $USER
# Log out and back in
```

**Permission denied:**
```bash
chmod +x *.sh
```

**Want to inspect the container:**
```bash
docker run --rm -it -v "$PWD/..:/chezmoi-source:ro" chezmoi-test bash
```
