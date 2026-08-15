# pg-flyway-migrate

A Helm chart to run Flyway-based database migrations against a PostgreSQL instance.  
Designed for CI/CD pipelines and GitOps workflows (ArgoCD/ApplicationSet-ready).

---

## 📌 Features

- Supports automatic DB creation using `bitnami/postgresql` client
- Clones migration files from Git (via `alpine/git`)
- Runs Flyway migrations (`flyway/flyway`)
- Parameterized values (image versions, git, DB, etc.)
- Bitnami-style chart structure

---

## 🛠️ Configuration

You can override the default values using `override.yml`. Example:

```yaml
db:
  host: postgres
  port: 5432
  dbName: dbname
  user: postgres
  password: "securePassword"
```

### Flyway Migrations Configuration

The following parameters configure how Flyway handles migration files:

- `enabled`: Whether to enable Flyway-based migrations.
- `migration_path`: Relative path inside the cloned Git repository to the folder containing Flyway SQL migrations. Defaults to `migrations`.
- `git.host`: Git host to clone the repository from.
- `git.username`: Username used to authenticate against the Git host.
- `git.repository`: Repository path (e.g., `/team/project.git`).
- `git.ref`: Branch or tag to checkout.

---