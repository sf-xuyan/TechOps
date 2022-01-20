# [git-crypt](https://buddy.works/guides/git-crypt)
## Git-crypt and GPG installation
```bash
brew install git-crypt
brew install gpg
```

## Repository and git-crypt initialization
```bash
git init
git-crypt init
```

## Defining files to encrypt
1. put your credentials into one folder, i.e secretfile
2. create a .gitattributes file
```bash
mkdir .gitattributes
```
3. add the following text to the body of .gitattributes file
<pre>
.gitattributes !filter !diff

secretfile/** filter=git-crypt diff=git-crypt
</pre>

## Testing encryption
```bash
git-crypt status -e
```

## Commits, pushes & encryption
```bash
git add .
git commit -m 'init commit'
git remote add origin REMOTE_URL
git push master
```

## Working in team with git-crypt
you can do one of two things:
1. Share the encryption key with them (symmetric key).
2. Add their GPG key to authorized keys.

### Symmetric key
```bash
git-crypt export-key path/where/key/should/be/saved
git-crypt unlock path/to/key
```

## GPG key
```bash
gpg --gen-key
gpg --list-keys
gpg --export --armor $KEY_ID
gpg --import /path/to/file
git-crypt add-gpg-user --trusted $EMAIL
git-crypt unlock
```

## Git-crypt in CI/CD process
The decryption is performed with symmetric key uploaded to the `Git-crypt unlock` action.
Once all tasks are performed, you can secure the files once again with `Git-crypt lock`.