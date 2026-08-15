# progenitor

Universal Helm chart for deploying containerized applications with Kubernetes Deployment and Service resources.

The chart is published as an OCI package to Docker Hub: `oci://registry-1.docker.io/denisitpro/progenitor`.

Artifact page: <https://hub.docker.com/r/denisitpro/progenitor>

## Installation

From the OCI registry:

```bash
helm install my-app oci://registry-1.docker.io/denisitpro/progenitor \
  --version 4.0.0 \
  -f custom-values.yaml
```

From a local checkout:

```bash
helm install my-app ./progenitor -f custom-values.yaml
```

Inspect the default values before installing:

```bash
helm show values oci://registry-1.docker.io/denisitpro/progenitor --version 4.0.0
```

## Configuration

Key configuration parameters in `values.yaml`:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of pod replicas (ignored if autoscaling enabled) | `1` |
| `nameOverride` | Override chart name | `""` |
| `fullnameOverride` | Override full resource name | `""` |
| `extraLabels` | Extra labels for all resources and pods | `{}` |
| `podAnnotations` | Annotations for pods | `{}` |
| `containerName` | Container name | Chart name |
| `image.registry` | Container registry | `docker.io` |
| `image.repository` | Image repository | `company/progenitor` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `imagePullSecrets` | Image pull secrets for private registries | `[]` |
| `command` | Container command override | `[]` |
| `args` | Container args override | `[]` |
| `initContainers` | Init containers to run before main container | `[]` |
| `jobs.enabled` | Enable Jobs for one-time tasks (migrations, etc.) | `false` |
| `jobs.resources` | List of Job resources with ArgoCD hooks support | `[]` |
| `cronjobs.enabled` | Enable CronJobs for scheduled tasks | `false` |
| `cronjobs.resources` | List of CronJob resources | `[]` |
| `serviceAccountName` | Service account name | `default` |
| `env` | Environment variables as key-value map | `{}` |
| `envRaw` | Raw environment variables (valueFrom, etc.) | `[]` |
| `envFrom` | Additional envFrom entries | `[]` |
| `configMaps.env.enabled` | Enable ConfigMap for environment variables | `false` |
| `configMaps.env.data` | Key-value pairs for env variables | `{}` |
| `configMaps.files.enabled` | Enable multiple ConfigMaps for configuration files | `false` |
| `configMaps.files.resources` | List of ConfigMap resources with individual mount paths | `[]` |
| `secrets.enabled` | Enable Vault secrets for envFrom | `false` |
| `vaultStaticSecrets.enabled` | Enable VaultStaticSecret CRs | `false` |
| `vaultStaticSecrets.defaultMount` | Default Vault mount path | `secret` |
| `vaultStaticSecrets.defaultType` | Default Vault secret type | `kv-v2` |
| `vaultStaticSecrets.defaultVaultAuthRef` | Default VaultAuth reference | undefined |
| `vaultStaticSecrets.labels` | Labels for VaultStaticSecret resources | `{}` |
| `vaultStaticSecrets.annotations` | Annotations for VaultStaticSecret (e.g., sync-wave) | `{}` |
| `vaultStaticSecrets.secrets` | List of VaultStaticSecrets to create | `[]` |
| `volumes` | Pod volumes | `[]` |
| `volumeMounts` | Container volume mounts | `[]` |
| `strategy` | Deployment update strategy | `{}` |
| `podSecurityContext` | Pod security context | `{}` |
| `securityContext` | Container security context | `{}` |
| `terminationGracePeriodSeconds` | Termination grace period | `30` |
| `hostAliases` | Host aliases to add to /etc/hosts in container | `[]` |
| `service.enabled` | Enable Service resource | `true` |
| `service.type` | Service type | `ClusterIP` |
| `service.annotations` | Service annotations | `{}` |
| `service.clusterIP` | Static ClusterIP address | `""` |
| `service.publishNotReadyAddresses` | Publish addresses for not ready pods | `false` |
| `service.noSelector` | Create service without selector | `false` |
| `livenessProbe.enabled` | Enable liveness probe | `false` |
| `livenessProbe.httpGet` | HTTP probe config | undefined |
| `livenessProbe.custom` | Custom probe (exec, grpc, etc.) | undefined |
| `readinessProbe.enabled` | Enable readiness probe | `false` |
| `readinessProbe.httpGet` | HTTP probe config | undefined |
| `readinessProbe.custom` | Custom probe | undefined |
| `nodeSelector` | Node selector | `{}` |
| `affinity` | Pod affinity rules | `{}` |
| `tolerations` | Pod tolerations | `[]` |
| `enableServiceLinks` | Enable service links in pods | `true` |
| `autoscaling.enabled` | Enable HPA autoscaling | `false` |
| `metrics.enabled` | Enable Prometheus metrics labels | `false` |
| `resources.requests.cpu` | CPU request | `300m` |
| `resources.requests.memory` | Memory request | `512Mi` |
| `resources.limits.cpu` | CPU limit | `1` |
| `resources.limits.memory` | Memory limit | `1024Mi` |
| `ingress.enabled` | Enable Ingress resource | `false` |
| `ingress.className` | Ingress class name (nginx or kong) | `nginx` |
| `ingress.name` | Ingress resource name (defaults to fullname) | `""` |
| `ingress.labels` | Additional labels for Ingress | `{}` |
| `ingress.annotations` | Additional annotations | `{}` |
| `ingress.nginxAnnotations` | Nginx-specific annotations | `{}` |
| `ingress.kongAnnotations` | Kong-specific annotations | `{}` |
| `ingress.tls.enabled` | Enable TLS | `false` |
| `ingress.tls.secretName` | TLS secret name | undefined |
| `ingress.tls.hosts` | TLS hosts | `[]` |
| `ingress.rules` | Ingress rules | `[]` |
| `ingress.acl.enabled` | Enable ACL/IP whitelisting | `false` |
| `ingress.acl.whitelistSourceRange` | Allowed IP addresses/CIDR ranges | undefined |
| `ingress.basicAuth.enabled` | Enable HTTP Basic Authentication | `false` |
| `ingress.basicAuth.secretName` | Secret containing auth credentials | undefined |
| `ingress.basicAuth.authRealm` | Authentication realm (Nginx only) | undefined |
| `ingress.basicAuth.hideCredentials` | Hide credentials from upstream (Kong only) | `true` |
| `ingress.basicAuth.anonymousConsumer` | Anonymous consumer (Kong only) | undefined |
| `ingress.nginx.enabled` | Enable Nginx Ingress with multiple resources | `false` |
| `ingress.nginx.defaultIngressClass` | Default IngressClass for nginx resources | `nginx` |
| `ingress.nginx.resources` | List of Nginx Ingress resources | `[]` |
| `servicesExternal.enabled` | Enable multiple external services | `false` |
| `servicesExternal.resources` | List of external service resources | `[]` |

## Examples

### Basic deployment

```yaml
image:
  repository: example-org/my-app
  tag: "1.0.0"

env:
  LOG_LEVEL: "info"
  DATABASE_URL: "postgres://db:5432/mydb"
```

### With custom ports

```yaml
containerPorts:
  - name: http
    containerPort: 8080
    protocol: TCP
  - name: metrics
    containerPort: 9090
    protocol: TCP

service:
  ports:
    - name: http
      port: 80
      targetPort: http
      protocol: TCP
    - name: metrics
      port: 9090
      targetPort: metrics
      protocol: TCP
```

### With health checks

```yaml
livenessProbe:
  enabled: true
  httpGet:
    path: /healthz
    port: http
  initialDelaySeconds: 30
  periodSeconds: 10

readinessProbe:
  enabled: true
  httpGet:
    path: /ready
    port: http
  initialDelaySeconds: 5
  periodSeconds: 5
```

### With Vault secrets (envFrom)

```yaml
secrets:
  enabled: true
  vaultSecrets:
    - secretName: app-database-credentials
    - secretName: app-api-keys
```

### With VaultStaticSecret (Vault Secrets Operator)

```yaml
vaultStaticSecrets:
  enabled: true
  defaultMount: secret
  defaultType: kv-v2
  defaultVaultAuthRef: vault-auth  # Default auth for all secrets
  secrets:
    - secretName: app-database
      path: dev1/myapp/database
    - secretName: app-api-keys
      path: dev1/myapp/api-keys
      vaultAuthRef: custom-vault-auth  # Override auth for specific secret
      includeKeys:
        - API_KEY
        - API_SECRET
    - secretName: global-config
      path: global/common-config
      mount: secret
      refreshAfter: 60s
      rolloutRestartTargets:
        - kind: Deployment
```

### VaultStaticSecret with auto-restart on changes

```yaml
vaultStaticSecrets:
  enabled: true
  secrets:
    - secretName: dynamic-config
      path: prod/myapp/config
      refreshAfter: 30s
      rolloutRestartTargets:
        - kind: Deployment
          name: "{{ include \"progenitor.fullname\" . }}"
      destination:
        create: true
        overwrite: true
        annotations:
          description: "Auto-updated configuration"
```

### VaultStaticSecret with a custom Secret type (e.g. basic-auth for CloudNativePG)

By default the destination Secret is created with type `Opaque`. Set `destination.type` to
produce a typed Secret — for example `kubernetes.io/basic-auth`, which CloudNativePG requires
for managed-role `passwordSecret`/`superuserSecret` (keys `username`/`password`, label
`cnpg.io/reload: "true"`). Setting a custom type requires `destination.create: true` (the default).

```yaml
vaultStaticSecrets:
  enabled: true
  defaultMount: secret
  secrets:
    - secretName: app-db-role
      path: dev1/myapp/db-role
      destination:
        create: true
        type: kubernetes.io/basic-auth   # optional; defaults to Opaque
        labels:
          cnpg.io/reload: "true"
      templates:
        username:
          text: '{{ .Secrets.username }}'
        password:
          text: '{{ .Secrets.password }}'
```

### VaultStaticSecret with key filtering

```yaml
vaultStaticSecrets:
  enabled: true
  secrets:
    - secretName: filtered-secrets
      path: dev1/myapp/all-secrets
      includeKeys:  # Only include these keys
        - DB_PASSWORD
        - API_KEY
        - JWT_SECRET
    - secretName: excluded-secrets
      path: dev1/myapp/sensitive
      excludeKeys:  # Exclude these keys
        - INTERNAL_ONLY
        - DEBUG_TOKEN
```

### VaultStaticSecret with ArgoCD sync-wave for Jobs

When Jobs need secrets to be ready before execution, use sync-wave annotations:

```yaml
# VaultStaticSecret created first (wave -5)
vaultStaticSecrets:
  enabled: true
  annotations:
    argocd.argoproj.io/sync-wave: "-5"
  secrets:
    - secretName: app-database-credentials
      path: dev1/myapp/database

# Job runs after secrets (wave 0) with delay for Vault operator
jobs:
  enabled: true
  resources:
    - name: migration
      command: ["/bin/sh", "-c"]
      args:
        - |
          echo "Waiting for Vault operator to create secrets..."
          sleep 15
          ./migrate.sh
      argocd:
        hook: PreSync
        hookDeletePolicy: HookSucceeded,BeforeHookCreation
        syncWave: 0  # VaultStaticSecret with wave -5 creates first
      backoffLimit: 2
      ttlSecondsAfterFinished: 300
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "500m"
          memory: "512Mi"

# Main deployment inherits secrets
secrets:
  enabled: true
  vaultSecrets:
    - secretName: app-database-credentials
```

### With Prometheus metrics

```yaml
metrics:
  enabled: true
  labels:
    prometheus.io/scrape: "true"
    prometheus.io/port: "3000"
    prometheus.io/path: "/metrics"
```

### Headless service for StatefulSet

```yaml
service:
  type: ClusterIP
  clusterIP: None
  publishNotReadyAddresses: true
  ports:
    - name: http
      port: 3000
      targetPort: http
      protocol: TCP
```

### Service with annotations (e.g., AWS NLB)

```yaml
service:
  type: LoadBalancer
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: "true"
  ports:
    - name: http
      port: 80
      targetPort: http
      protocol: TCP
```

### Service with template in annotations

```yaml
# Define variable in values
staticVersion: "305944e"

service:
  annotations:
    server-snippet: |
      location /version {
        return 200 "{{ .Values.staticVersion }}";
      }
```

### External service without selector

```yaml
service:
  enabled: false
  noSelector: true
  type: ClusterIP
  ports:
    - name: http
      port: 3000
      targetPort: 3000
      protocol: TCP
```

### External service with ExternalName (DNS alias)

```yaml
servicesExternal:
  enabled: true
  resources:
    - name: database
      type: ExternalName
      externalName: "database.external.example.com"
      ports:
        - name: postgresql
          port: 5432
          protocol: TCP
```

### External service with manual endpoints

```yaml
servicesExternal:
  enabled: true
  resources:
    - name: api
      type: ClusterIP
      noSelector: true
      ports:
        - name: http
          port: 3000
          protocol: TCP
      endpoints:
        enabled: true
        subsets:
          - addresses:
              - ip: "10.0.1.10"
              - ip: "10.0.1.11"
            ports:
              - name: http
                port: 3000
                protocol: TCP
```

### External service with external IPs

```yaml
servicesExternal:
  enabled: true
  resources:
    - name: loadbalancer
      type: ClusterIP
      externalIPs:
        - "203.0.113.10"
        - "203.0.113.11"
      ports:
        - name: http
          port: 80
          targetPort: http
          protocol: TCP
```

### Multiple external services

```yaml
servicesExternal:
  enabled: true
  resources:
    # External database
    - name: database
      type: ExternalName
      externalName: "postgres.external.example.com"
      ports:
        - name: postgresql
          port: 5432
          protocol: TCP
    
    # External API with manual endpoints
    - name: api
      type: ClusterIP
      noSelector: true
      ports:
        - name: http
          port: 8080
          protocol: TCP
      endpoints:
        enabled: true
        subsets:
          - addresses:
              - ip: "10.0.2.10"
              - ip: "10.0.2.11"
            ports:
              - name: http
                port: 8080
                protocol: TCP
    
    # External cache
    - name: cache
      type: ClusterIP
      externalIPs:
        - "203.0.113.20"
      ports:
        - name: redis
          port: 6379
          protocol: TCP
```

### With custom command and args

```yaml
command:
  - "/bin/sh"
  - "-c"

args:
  - "npm run migrate && npm start"
```

### With init containers

Init containers support intelligent image resolution:
- **No image field**: Uses main container image (ensures version consistency for migrations)
- **Image without tag**: Appends main container tag
- **Full image path**: Uses as-is

```yaml
initContainers:
  # Run database migrations with same version as main app
  - name: migration
    # No image field - will use main container image:tag
    command: ["./migrate.sh"]
    env:
      - name: DATABASE_URL
        valueFrom:
          secretKeyRef:
            name: db-credentials
            key: url
  
  # Wait for database with specific version
  - name: wait-for-db
    image: busybox:1.35
    command: ['sh', '-c', 'until nc -z postgres 5432; do echo waiting for db; sleep 2; done']
  
  # Custom init tool that tracks main app version
  - name: setup
    image: docker.io/company/init-tool
    # Will append main container tag, e.g., init-tool:v1.5.2
    command: ["./setup.sh"]
```

### With init containers and shared volumes

```yaml
initContainers:
  - name: download-config
    image: busybox:1.35
    command: ['sh', '-c', 'wget -O /config/app.conf https://example.com/config']
    volumeMounts:
      - name: config
        mountPath: /config

volumes:
  - name: config
    emptyDir: {}

volumeMounts:
  - name: config
    mountPath: /etc/app/config
```

### With Jobs (migrations with ArgoCD hooks)

Jobs are better than initContainers for migrations because they:
- Run only once (not in every replica)
- Have proper retry logic with backoffLimit
- Support ArgoCD PreSync hooks (run before deployment)
- Provide better visibility in Kubernetes/ArgoCD UI

```yaml
# Enable Jobs
jobs:
  enabled: true
  resources:
    # Database migration with ArgoCD PreSync hook
    - name: migration
      # No image - uses main container image:tag
      command: ["./migrate.sh"]
      args: ["--verbose"]
      backoffLimit: 2  # Retry up to 2 times
      activeDeadlineSeconds: 600  # 10 minute timeout
      ttlSecondsAfterFinished: 300  # Cleanup after 5 minutes
      # ArgoCD hook - runs BEFORE deployment update
      argocd:
        hook: PreSync
        hookDeletePolicy: HookSucceeded,BeforeHookCreation
        syncWave: 0
      env:
        MIGRATION_MODE: "up"
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "500m"
          memory: "512Mi"
    
    # Data import with PostSync hook
    - name: data-import
      command: ["./import.sh"]
      argocd:
        hook: PostSync  # Run AFTER deployment
        hookDeletePolicy: HookSucceeded
      backoffLimit: 3

# Main deployment inherits secrets and env
secrets:
  enabled: true
  vaultSecrets:
    - secretName: db-credentials

env:
  DATABASE_HOST: "postgres.example.com"
  DATABASE_PORT: "5432"
```

### With CronJobs (scheduled tasks)

```yaml
# Enable CronJobs
cronjobs:
  enabled: true
  resources:
    # Daily cleanup at 2 AM UTC
    - name: daily-cleanup
      schedule: "0 2 * * *"
      timeZone: "UTC"
      # No image - uses main container image:tag
      command: ["./cleanup.sh"]
      args: ["--days", "30"]
      concurrencyPolicy: Forbid  # Prevent overlapping executions
      successfulJobsHistoryLimit: 3
      failedJobsHistoryLimit: 1
      backoffLimit: 2
      env:
        CLEANUP_MODE: "soft"
      resources:
        requests:
          cpu: "50m"
          memory: "64Mi"
        limits:
          cpu: "200m"
          memory: "256Mi"
    
    # Hourly data sync
    - name: hourly-sync
      schedule: "0 * * * *"
      command: ["./sync.sh"]
      concurrencyPolicy: Forbid
      successfulJobsHistoryLimit: 5
      backoffLimit: 3
    
    # Weekly report with custom image
    - name: weekly-report
      schedule: "0 0 * * 0"  # Sunday at midnight
      timeZone: "America/New_York"
      image: docker.io/company/report-generator:v1.0.0
      command: ["./generate-report.sh"]
      args: ["--format", "pdf"]
      successfulJobsHistoryLimit: 10

# CronJobs inherit secrets and env from main deployment
secrets:
  enabled: true
  vaultSecrets:
    - secretName: app-credentials
```

### With volumes and volume mounts

```yaml
volumes:
  - name: config
    configMap:
      name: app-config
  - name: cache
    emptyDir:
      sizeLimit: 1Gi
  - name: secrets
    secret:
      secretName: app-secrets

volumeMounts:
  - name: config
    mountPath: /etc/app/config
    readOnly: true
  - name: cache
    mountPath: /tmp/cache
  - name: secrets
    mountPath: /etc/secrets
    readOnly: true
```

### With ConfigMap for environment variables

```yaml
configMaps:
  env:
    enabled: true
    data:
      DATABASE_HOST: "postgres.default.svc.cluster.local"
      DATABASE_PORT: "5432"
      REDIS_HOST: "redis.default.svc.cluster.local"
      REDIS_PORT: "6379"
      APP_ENV: "production"
      LOG_LEVEL: "info"
```

### With ConfigMap for configuration files (single)

```yaml
configMaps:
  files:
    enabled: true
    resources:
      - name: app-config
        mountPath: /etc/app
        data:
          config.json: |
            {
              "server": {
                "port": 3000,
                "host": "0.0.0.0"
              },
              "database": {
                "pool": {
                  "min": 2,
                  "max": 10
                }
              },
              "logging": {
                "level": "info",
                "format": "json"
              }
            }
          application.yml: |
            server:
              port: 3000
              timeout: 30s
            
            database:
              pool:
                min: 2
                max: 10
              connection_timeout: 5s
            
            cache:
              ttl: 3600
              max_entries: 1000
```

### With multiple ConfigMaps (different mount paths)

```yaml
configMaps:
  files:
    enabled: true
    resources:
      # Application configuration
      - name: app-config
        mountPath: /etc/app
        data:
          config.json: |
            {
              "server": {"port": 3000},
              "logging": {"level": "info"}
            }
      
      # Nginx configuration
      - name: nginx-config
        mountPath: /etc/nginx/conf.d
        data:
          default.conf: |
            server {
              listen 8080;
              location / {
                proxy_pass http://backend:3000;
                proxy_set_header Host $host;
              }
            }
      
      # Startup scripts
      - name: scripts
        mountPath: /opt/scripts
        data:
          startup.sh: |
            #!/bin/bash
            echo "Starting application..."
            /app/migrate.sh && exec /app/server
          healthcheck.sh: |
            #!/bin/bash
            curl -f http://localhost:3000/health || exit 1
```

### With advanced environment variables

```yaml
env:
  APP_ENV: production
  LOG_LEVEL: info

envRaw:
  - name: POD_NAME
    valueFrom:
      fieldRef:
        fieldPath: metadata.name
  - name: POD_IP
    valueFrom:
      fieldRef:
        fieldPath: status.podIP
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: database-credentials
        key: password

envFrom:
  - configMapRef:
      name: common-config
  - secretRef:
      name: api-keys
```

### With private registry

```yaml
imagePullSecrets:
  - name: docker-registry-credentials
  - name: gcr-credentials
```

### With custom deployment strategy

```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 2
    maxUnavailable: 0
```

### With host aliases (custom /etc/hosts entries)

```yaml
hostAliases:
  - ip: "1.2.3.4"
    hostnames:
      - "legacy-api.example.com"
      - "old-backend.internal.com"
  - ip: "5.6.7.8"
    hostnames:
      - "staging-db.example.com"
      - "test-cache.example.com"
```

### With host aliases for debugging/development

```yaml
hostAliases:
  - ip: "127.0.0.1"
    hostnames:
      - "local-api.example.com"
      - "debug.example.com"
  - ip: "10.0.1.100"
    hostnames:
      - "internal-service.company.local"
      - "monitoring.company.local"
```

### With security contexts

```yaml
podSecurityContext:
  runAsNonRoot: true
  runAsUser: 1000
  fsGroup: 2000
  seccompProfile:
    type: RuntimeDefault

securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  runAsUser: 1000
```

### With node scheduling (nodeSelector, affinity, tolerations)

```yaml
nodeSelector:
  disktype: ssd
  nodepool: production

affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app.kubernetes.io/name: myapp
          topologyKey: kubernetes.io/hostname

tolerations:
  - key: "node.kubernetes.io/unreachable"
    operator: "Exists"
    effect: "NoExecute"
    tolerationSeconds: 30
  - key: "special-workload"
    operator: "Equal"
    value: "true"
    effect: "NoSchedule"
```

### With custom probes (exec, grpc)

```yaml
livenessProbe:
  enabled: true
  custom:
    exec:
      command:
        - cat
        - /tmp/healthy
    initialDelaySeconds: 30
    periodSeconds: 10

readinessProbe:
  enabled: true
  custom:
    grpc:
      port: 9090
    initialDelaySeconds: 5
    periodSeconds: 5
```

### With autoscaling

```yaml
autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 80
  targetMemoryUtilizationPercentage: 80

# replicaCount is ignored when autoscaling is enabled
```

### With extra labels and pod annotations

```yaml
extraLabels:
  team: platform
  environment: production
  cost-center: engineering

podAnnotations:
  prometheus.io/scrape: "true"
  prometheus.io/port: "9090"
  vault.hashicorp.com/agent-inject: "true"
```

### Optimized for large clusters

```yaml
# Disable service links to reduce environment variables
enableServiceLinks: false

# Set appropriate termination grace period
terminationGracePeriodSeconds: 60
```

### Nginx Ingress - Basic setup (single endpoint)

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: app-ingress
        rules:
          - host: example.com
            paths:
              - path: /
                pathType: Prefix
                service:
                  port: http
```

### Nginx Ingress - Multiple endpoints on same domain

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: public-api
        rules:
          - host: example.com
            paths:
              - path: /api/public
                pathType: Prefix
                service:
                  port: http
      - name: admin-api
        rules:
          - host: example.com
            paths:
              - path: /api/admin
                pathType: Prefix
                service:
                  port: http
```

### Nginx Ingress - With TLS and SSL redirect

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: app-ingress
        tls:
          enabled: true
          secretName: example-tls
          hosts:
            - example.com
        nginxAnnotations:
          sslRedirect: "true"
        rules:
          - host: example.com
            paths:
              - path: /
                pathType: Prefix
                service:
                  port: http
```

### Nginx Ingress - With path rewrite (strip prefix)

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: api-ingress
        nginxAnnotations:
          useRegex: "true"
          rewriteTarget: "/$2"
        rules:
          - host: example.com
            paths:
              - path: /api(/|$)(.*)
                pathType: ImplementationSpecific
                service:
                  port: 8080
```

### Nginx Ingress - With ACL (IP whitelisting)

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: admin-ingress
        acl:
          enabled: true
          whitelistSourceRange: "10.0.0.0/8,192.168.1.0/24,1.2.3.4/32"
        rules:
          - host: admin.example.com
            paths:
              - path: /
                pathType: Prefix
                service:
                  port: http
```

### Nginx Ingress - With HTTP Basic Authentication

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: secure-api
        basicAuth:
          enabled: true
          secretName: app-basic-auth
          authRealm: "Authentication Required - App"
        rules:
          - host: secure.example.com
            paths:
              - path: /
                pathType: Prefix
                service:
                  port: http
```

### Nginx Ingress - With ACL and Basic Auth

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: admin-api
        acl:
          enabled: true
          whitelistSourceRange: "10.0.0.0/8,192.168.1.0/24"
        basicAuth:
          enabled: true
          secretName: admin-basic-auth
          authRealm: "Admin Area - Authentication Required"
        rules:
          - host: admin.example.com
            paths:
              - path: /
                pathType: Prefix
                service:
                  port: http
```

### Nginx Ingress - With custom annotations

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      - name: api-ingress
        nginxAnnotations:
          corsEnabled: "true"
          backendProtocol: "HTTPS"
          custom:
            nginx.ingress.kubernetes.io/proxy-body-size: "50m"
            nginx.ingress.kubernetes.io/proxy-connect-timeout: "600"
            nginx.ingress.kubernetes.io/proxy-send-timeout: "600"
            nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
        rules:
          - host: api.example.com
            paths:
              - path: /
                pathType: Prefix
                service:
                  port: https
```

### Nginx Ingress - Different auth per endpoint (same domain)

```yaml
ingress:
  nginx:
    enabled: true
    resources:
      # Public endpoint - no auth
      - name: public-api
        rules:
          - host: example.com
            paths:
              - path: /api/public
                pathType: Prefix
                service:
                  port: http
      
      # Secured endpoint - with basic auth
      - name: secure-api
        basicAuth:
          enabled: true
          secretName: user-basic-auth
          authRealm: "User Area"
        rules:
          - host: example.com
            paths:
              - path: /api/user
                pathType: Prefix
                service:
                  port: http
      
      # Admin endpoint - with basic auth + IP whitelist
      - name: admin-api
        acl:
          enabled: true
          whitelistSourceRange: "10.0.0.0/8,192.168.1.0/24"
        basicAuth:
          enabled: true
          secretName: admin-basic-auth
          authRealm: "Admin Area"
        rules:
          - host: example.com
            paths:
              - path: /api/admin
                pathType: Prefix
                service:
                  port: http
```

### Kong Ingress - Basic setup

```yaml
ingress:
  enabled: true
  className: kong
  rules:
    - host: example.com
      paths:
        - path: /
          pathType: Prefix
          service:
            port: http
```

### Kong Ingress - With TLS and Kong annotations

```yaml
ingress:
  enabled: true
  className: kong
  tls:
    enabled: true
    secretName: example-tls
    hosts:
      - example.com
  kongAnnotations:
    stripPath: "true"
    preserveHost: "true"
    protocols: "https"
    httpsRedirectStatusCode: "301"
  rules:
    - host: example.com
      paths:
        - path: /api
          pathType: Prefix
          service:
            port: 8080
```

### Kong Ingress - With ACL (IP whitelisting)

```yaml
ingress:
  enabled: true
  className: kong
  acl:
    enabled: true
    whitelistSourceRange: "10.0.0.0/8,192.168.1.0/24,1.2.3.4/32"
  rules:
    - host: admin.example.com
      paths:
        - path: /
          pathType: Prefix
          service:
            port: http
```

### Kong Ingress - With HTTP Basic Authentication

```yaml
ingress:
  enabled: true
  className: kong
  basicAuth:
    enabled: true
    secretName: app-basic-auth
    hideCredentials: true
  rules:
    - host: secure.example.com
      paths:
        - path: /
          pathType: Prefix
          service:
            port: http
```

### Kong Ingress - With ACL and Basic Auth

```yaml
ingress:
  enabled: true
  className: kong
  acl:
    enabled: true
    whitelistSourceRange: "10.0.0.0/8,172.16.0.0/12"
  basicAuth:
    enabled: true
    secretName: admin-basic-auth
    hideCredentials: true
  rules:
    - host: admin.example.com
      paths:
        - path: /
          pathType: Prefix
          service:
            port: http
```

### Kong Ingress - Multiple paths with custom service

```yaml
ingress:
  enabled: true
  className: kong
  rules:
    - host: example.com
      paths:
        - path: /api
          pathType: Prefix
          service:
            name: api-service
            port: 8080
        - path: /admin
          pathType: Prefix
          service:
            name: admin-service
            port: 9090
```

### Kong Ingress - With custom Kong annotations

```yaml
ingress:
  enabled: true
  className: kong
  kongAnnotations:
    stripPath: "false"
    preserveHost: "true"
    methods: "GET,POST,PUT"
    custom:
      konghq.com/request-buffering: "true"
      konghq.com/response-buffering: "true"
      konghq.com/connect-timeout: "60000"
      konghq.com/read-timeout: "60000"
  rules:
    - host: api.example.com
      paths:
        - path: /v1
          pathType: Prefix
          service:
            port: http
```
