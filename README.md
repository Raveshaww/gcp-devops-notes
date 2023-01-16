# google_devops
Mostly following through A Cloud Guru's content, but will supplement as needed
# Notes
### GCP Cloud Concepts
- Services can generally be broken into four categories
    - Compute
    - Storage
    - Big Data
    - Machine Learning
- Compute Engine is a VM
### Intro to GCP
- GCP Foundations
    - Launched in 2008
    - Edge locations can act as a sort of CDN
- Identity Access Management
    - IAM documents any activity on the account
    - `Organizations` are the root of the hierarchy, kinda like an Azure account
    - `Folders` act like subscriptions in Azure
    - `Projects` are like resource groups
- Networking
    - VPC, routes, and firewall rules are global resources
    - Subnets are regional
    - You do get a default network and subnets created for you
    - The GUI config will actually give you a copy of the CLI version of what you configured
- Compute Engine Instance
    - Custom OS options are available
    - Tags are also known as simply `metadata`
    - There are four different types
        - `E` is for general purpose
        - `M` is for memory optimize
        - `N` is General purpose, but balanced price / performance
        - `C` is for compute
- Cloud Storage
    - Bucket names are globally unique
    - There are various classes based on the need for access and availability
        - `Storage` for frequent access and short live
        - `Nearline` for infrequently accessed data
        - `Coldline` is best for disaster recovery
        - `Archive`
    - Autoclass is an option for per object classification
        - Once you go to a standard class, you can't go back
- Database Services
    - Relational:
        - Cloud SQL
            - MySQL
            - PostgreSQL
            - SQL Server
        - Cloud Spanner is globally distributed
    - Non-relational
        - Big table
        - Firestore is fully managed
        - Memory Store is in-memory
- Big Data and Messaging
    - Big Query is a data warehouse
    - Google Dataflow is a managed Apache Beam pipeline for data processing
    - Pub/Sub is a fully managed messaging service
        - You could use this as a sort of Azure Function type automation
- Advanced Major Services
    - Understanding Security
        - Data is encrypted in transit and in rest
    - How are resources monitored?
        - Cloud Monitoring is their version of Azure Monitor
### Cost Control on GCP
- Billing Organization
    - Billing accounts are also under the Organization layer
    - You can have multiple billing account
    - A single billing account can be associated with multiple projects
    - Projects need a billing account to even create billable resources
- Cost Visibility and Analysis
    - You can export billing data to BigQuery, but soon you will not be able to export this to Cloud Storage soon
- Reducing Costs on GCP
    - Many tools to help reduce costs are automatically implemented
    - Rightsizing recommendations will be made
    - Long running compute are automatically discounted
        - Does not stack with committed discounts
    - Preemptible VM (aka spot instances)
        - Max life of 24 hours regardless
### GCP Essentials
- Working with GCP
    - `Google Cloud Marketplace` is GCP's market place
    - Most things are billed per second
    - `Stack Driver` is GCP's integrated monitor and logging platform (Is this the final name?)
- Running Apps with Compute
    - App Engine is PaaS (basically Azure Service with some more features built in)
        - Auto scaling and auto load balancing
        - Standard env is more proprietary with limited language support, but a faster spin-up time and less expensive
        - Flexible env is based on docker
        - Blob store is legacy
        - Code scanning
    - GKE
        - Load balancing is integrated
        - node pools are supported
        - Auto scale for clusters and nodes
        - Auto upgrades
        - Auto repair
        - Auto logging and monitoring
    - Cloud Functions (basically azure functions)
        - Serverless
    - Managing Storage and Databases
        - `gsutil` stands for `google storage utility`
        - `Cloud Datastore` is NoSQL 
        - `Cloud Bigtable` is a fully managed massively scalable NoSql database
            - Considered a wide column database, instead of a document database
            - No SQL-like language is available
            - single key per row
### Google Certified Associate Cloud Engineer
- Intro to GCP
    - GCP's three pillars are
        - Trust and Security
            - Secure by design
        - Open Cloud
            - Open source
        - Analytics and AI
    - Networking is divided into three layers
        - VPC
        - Routers
        - Subnets
    - Security
        - Data at rest is chunked, encrypted, and stored across a range of servers
    - Database
        - Firestore is NoSQL
        - Firebase lets you store and sync data for your users in real time
    - Cloud shell
        - 5gb of storage
- Cloud Storage
    - Cloud Firestore is separate
        - Fully managed NFS
    - Disks
        - Zonal is the default offered for VMs
        - Regional Persistent Disk
            - Replicated across two zones
        - Local SSD
- Compute Engine and VPC
    - Accelerator optimized is for high performance workloads like parallel computing and API
    - Managed instance group is a collection of VMs that you can manage as a single entity (tldr vm scaleset)
    - Snapshots seem to be the fastest way to "clone" an instance, and can be used to create a VM image
    - You are allowed to bring your IPs
    - Share VPC allows you to use one VPC with multiple projects
- Kubernetes
    - GKE
        - It's the open source K8S platform under the hood
        - Consists of compute engine machines to create a cluster
        - Broken into two things
            - control plane
                - manages worker nodes
                - consists of
                    - api server
                    - etcd
                    - scheduler (also monitors)
                    - control managers
            - nodes
                - A cluster is a group of one or nodes
                - Nodes run one or more pods
                    - Each node gets a cidr range
                - pods consist of
                    - container run time
                    - kubelet to ensure stuff is running
                    - kubeproxy for networking
                    - each pod has its own IP address
                - Kubectl lets you run commands against the cluster
- Cloud Functions
    - CLoud run can deploy containers (kinda like function app but with containers)
- GCP Monitoring and Logging Services
    - `cloud ops` is the name of the agent you install on VMs
- Big Data Resources
    - cloud dataproc is a managed Hadoop / mapreduce, etc
    - datalab enables interactive data exploration
### GCP DevOps Part 1
- Welcome!
    - You need to understand the business
    - You need to understand the teams inside the business
    - You need to understand processes and techniques
    - You need to understand the tech and tools at work
- About the Cert
    - Exam is about 2 hours
    - Google offers a practice exam
### GCP DevOps Part 2
- Balancing Change, Velocity, and Service Reliability with SREs
    - Big Picture
        - It's recommended that Dev and Ops share the same tools and techniques, like Jira and etc
    - SLI
        - Quantified level of availability
        - Some examples
            - request latency
            - failure rate
            - batch throughput
            - Traffic
            - Saturation
        - Transparent SLIs allow you to see GCP services SLIs 
        - SLI = ( Good events / valid events ) * 100
        - A good SLI shouldn't have frequent spikes in metrics - if charted, it should be a smooth and easy to read chart
        - Limit the number of SLIs
        - Reduce Complexity
            - Not all metrics make good SLIs
        - Prioritize journeys
            - Select most valuable to users
        - Aggregate similar SLIs
            - Turn into rate, average, or percentile
        - Bucket to distinguish response classes
            - Not all requests are the same
            - Requesters may be human or background apps
        - Collect data at load balancer
            - Collects data closer to the user
    - SLO
        - 100% reliability is not a good objective
        - Agreed-upon bounds on how often SLIs must be met
        - You may need to adjust your SLOs to allow for more user satisfaction
    - SLA
        - SREs are not usually involved in drafting SLAs
        - SLAs should be a bit below your SLOs for some wiggle room
- Making the Most of Risk
    - Setting Error Budgets
        - Balances innovation and reliability
        - Developers oversee own risk
        - If budget is exceeded
            - Releases temporarily halted
            - System testing and dev expanded
            - Performance improved
        - error budget = 100% - SLO
        - Error budget of 0.002 = 86.4 minutes a month
        - Error budgets are good
            - Releasing new features
            - Expected system changes
            - Inevitable failure
            - Planned downtime
            - Risky experiments
            - Unforeseen circumstances
    - Defining and Reducing Toil
        - Toil tends to be response-driven and not proactive
        - Devoid of enduring value
        - Toil is not
            - Email
            - expense reports
            - commuting
            - meetings
                - These are overhead
- Generating SRE Metrics
    - Monitoring Reliability
        - White-box monitoring
            - metrics exposed by internals of system
            - focus is on predicting problems before they happen
        - Black-box monitoring
            - Testing externally visible behavior as a user would see it
            - symptom-oriented active problems 
            - Best for paging
        - Alerts and dashboards typically use metrics
    - Alerting Principles
        - error budget burn rate = 100% - slo * (events / set time)
        - Slow burn alerting policy is to warn that your error budget is in trouble, but it is not as urgent
            - Needs a longer lookback period to notice
            - Threshold should be slightly higher
    - Investigating SRE Tools 
        - K8S engine 
        - Container registry
        - Cloud Build
        - Cloud source repos
        - Spinnaker for Google Cloud
            - Triggers pipelines and extend CI/CD pipeline
        - Cloud monitoring
        - Cloud logging
        - Cloud debugger
        - Cloud trace
        - Cloud profiler
            - keeps an eye on code performance
- Reacting to Incidents
    - Handling Incident Response
        - Specific roles should be designated to team, with full autonomy in their role
        - Roles should include:
            - Incident commander
                - In charge during incident, designating responsibilities and taking all roles not designated
            - Operational team 
                - The only team allowed to make changes, no freelancers
            - Communication Lead
                - Public face of IR
            - Planning lead
                - Supports Ops team with long-term actions and arranging hand-off, and tracking system changes
        - Established Command post
            - such as a physical location or a slack channel
            - Live incident state doc
        - Handoffs **must** be clear and communicated
        - It is recommended to rotate roles among team members
    - Managing Service Lifecycle
        - SRE help co-design the service
        - SRE can contribute to the creation of the service
        - The lifecycle is:
            - Architecture and design
            - Active Development
            - Limited availability
            - General availability
            - Depreciation
    - Ensuring Healthy Operations Collab
        - Postmortem agenda
            - gather metadata
                - what systems were affected?
                - Who responded?
                - Include machine readable data:
                    - Time to identify
                    - Time to act
                    - Time to resolve
            - build timeline
                - When and how was the incident reported?
                - When did the response start?
                - When and how did we make it better?
                - When was it over?
            - Generate report
                - Report will be initiated by incident commander
                - All participants need to add their own details on actions taken
                - Was there anything done that needs to be rolled back?
### GKE 
- Intro to Containers
    - In order to push to gcr.io, you need the full project name including the random numbers Google includes at the end of the project name
        - Example: `docker tag myapp gcr.io/learninggke-374700/myapp` > `docker push gcr.io/learninggke-374700/myapp`
- Intro to GKE
    - Clusters contain
        - one or more masters
            - These run the control plane
            - They make decisions
            - contains
                - etcd
                - api server
                - scheduler
                - cloud controller manager
                - kube controller manager
        - one or more nodes
            - Nodes are the workers
            - They are the resources of the cluster
            - Contains:
                - kubelet, which is a k8s agent to take instructions from the control plane
                - kube-proxy, for network connections
                - container runtime
    - You don't ever touch the master control panel in GKE
    - Everything in k8s is an object
    - In order to use kubectl, you need to get credentials
        - `gcloud container clusters get-credentials your-first-cluster-1 --zone=us-central1-c`
    - To create a deployment:
        - `kubectl create deployment nginx --image nginx`
    - To expose the endpoint:
        - `kubectl expose deployment nginx --port=80 --type=LoadBalancer`
    - A pod is the smallest deployable unit in k8s
    - Most pods will contain only one container, but some may contain more
        - an nginx container may be called a side car, for example
    - Containers in the same pod share the same environment (i.e. IP address and volumes)
    - Pods should be designed around a single application
    - You can port-forward to a pod with kubectl
        - `kubectl port-forward nginx 8080:80`
    - You can open an interactive shell with a pod
        - `kubectl exec -it multi -c ftp-container -- /bin/bash`
    - Copies of a pod are a ReplicaSet
    - We don't create ReplicaSets on their own, instead we use deployments
    - This allows the controller to enforce the desired state
    - A service exposes a set of pods to the network
    - A service assigns a fixed IP to your pod replicas
    - Three main types of service
        - clusterip assigns a fixed ip inside your cluster
        - nodeport assigns a specific port to every node inside your service
        - loadbalancer creates a loadbalancer in the provider you are using (i.e. google load balancer in gke)
    - Pods that match a label that is in a selector will be part of a specific service
    - Services also provide a built-in DNS name
    - Tainting a node tells a scheduler to not use the node
- Deploying Applications
- Advanced GKE Operations
- Wrapping up
### GCP DevOps Part 3
- Understanding GCP CI/CD Pipelines
    - Estimations that good QA can lead to a 33% cost reduction in development
    - Cost savings for CI/CD tends to be at least 10%
    - CI isn't necessarily about it being functionally so much as build-able
    - Continuous Delivery is about making sure that the code base is always releasable
- Cloud Source Repos
    - You can perform a one-way mirror with Github / Bitbucket
    - "google search for your code"
- Cloud Build
    - Cloud Build Concepts
        - Need to call a cloud builder via a yaml or json file
            - Typically called `cloudbuild.yaml`
        - A cloud builder runs in a container, and can be packaged with common languages and tools
            - You can use many different types of images
        - You could actually have cloud build simply run the dockerfile build instead
        - Triggers can publish to pub/sub for further automation
        - You want to make sure to give Cloud Build a service account
        - The command to manually send a build to Cloud Build is `gcloud builds submit`
        - When using triggers, Cloud Build will operate from the root level of the repo
    - Best PRactices for Build Performance
        - Leaner containers
            - Separate app build process and runtime build via cloudbuild file
        - Using cache options
        - Cut bloat
            - You can also include a .gcloudignore file
        - Adjust VM sizes (bigger is better)
- Artifact Management with Container Registry
    - Container Registry Concepts
        - For IAM permissions, cloud storage access is what is important here
        - Spinnaker / jenkins / etc on a GKE cluster will auth with the cluster service account
        - for CE, you need to assign the right **scope** to storage
- CD Overview
    - Cloud build will simply replace pods with newer version, so it's better to just use kubernetes itself to deploy new versions of the app
        - This also allows for more advanced methods of deployment
- Spinnaker
    - Concepts
        - GCP favors Spinnaker
        - It can take part in application management
        - It helps make k8s yaml files and handle kubectl commands
    - Set up
        - Google provides install scripts, though remember it's not natively integrated
            - some of the items it sets up:
                - GKE cluster
                - Redis database
                - Cloud storage bucket
                - service account
        - Web interface is called `deck`
        - There is a marketplace item that helps guide you through the install
        - cmdline is called `halyard`
        - You can either use the cloud shell to access the web console, or you can expose it via an identity aware proxy
    - Deploy
- Securing the Deployment Pipelines
- Full Dev Pipeline