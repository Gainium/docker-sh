# Contributing

Thanks for your interest in contributing! This project is licensed under
the **MIT License** (see [`LICENSE`](./LICENSE)). To keep the contribution
chain of trust clear and to certify that you have the right to submit the
code you contribute, **every commit must be signed off** using the
Developer Certificate of Origin (DCO).

## Sign-off — required on every commit

Add the `-s` flag every time you commit:

```bash
git commit -s -m "your commit message"
```

This appends a `Signed-off-by:` line to your commit message that looks like:

```
Signed-off-by: Your Name <your.email@example.com>
```

The line must contain a real name and a working email address (anonymous
or pseudonymous sign-offs are not accepted).

### What you're certifying

By adding `Signed-off-by`, you certify the
[Developer Certificate of Origin 1.1](https://developercertificate.org/),
which is a lightweight statement that you wrote the change yourself or
otherwise have the right to contribute it under the project's MIT license.
The full text:

> **Developer Certificate of Origin**
> Version 1.1
>
> By making a contribution to this project, I certify that:
>
> (a) The contribution was created in whole or in part by me and I have
>     the right to submit it under the open source license indicated in
>     the file; or
>
> (b) The contribution is based upon previous work that, to the best of
>     my knowledge, is covered under an appropriate open source license
>     and I have the right under that license to submit that work with
>     modifications, whether created in whole or in part by me, under the
>     same open source license (unless I am permitted to submit under a
>     different license), as indicated in the file; or
>
> (c) The contribution was provided directly to me by some other person
>     who certified (a), (b) or (c) and I have not modified it.
>
> (d) I understand and agree that this project and the contribution are
>     public and that a record of the contribution (including all personal
>     information I submit with it, including my sign-off) is maintained
>     indefinitely and may be redistributed consistent with this project
>     or the open source license(s) involved.

### Automating sign-off

Configure git once so every commit is automatically signed off:

```bash
git config user.name  "Your Name"
git config user.email "your.email@example.com"
# add to commits in this repo automatically:
git config format.signoff true
```

If you forgot to sign-off a commit, amend the last one:

```bash
git commit --amend --signoff --no-edit
```

For a chain of commits, rebase and sign-off:

```bash
git rebase --signoff HEAD~<N>
```

## Pull requests

- Open the PR against `main`.
- Keep the diff small and focused — one PR per logical change.
- Update [`CHANGELOG.md`](./CHANGELOG.md) if the change is user-visible.
- CI must be green before review.

PRs without a `Signed-off-by` line on every commit will be blocked until
the sign-off is added.

## Reporting bugs / security issues

For non-sensitive bug reports, open an issue. For security-sensitive
reports, email **security@gainium.io** rather than filing a public issue.

## License

By submitting a contribution, you agree that it will be licensed under the
MIT License terms in [`LICENSE`](./LICENSE).
