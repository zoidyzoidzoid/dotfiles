# Homebrew Backup

[brew](https://brew.sh/) is great, and backing it up is easy:

```
brew bundle dump
```

And restoring is as easy as running the generated `brew.sh`:

```
brew bundle
```

P.S. I originally used [`brew backup`](https://github.com/rstacruz/homebrew-backup) which is deprecated.
