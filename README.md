# Kwil DB Administrator

For this Arweave Hackathon I have focused on creating extensions and administrative tools for Kwil DB.
There are several repositories included as part of this project but this is the core repository.  Details of the other repositories will be included below.

## About
I am currently working on a Web3 project called Embrace Community and I've been looking for a reliable database that is decentralised and that easily connects to other Web3 infrastructure e.g. Arweave / Ethereum.  
This has been my motivation with creating extensions and tools for Kwil DB during this hackathon.
<div style="display: flex; justify-content: center;">
<img src="https://lets.embrace.community/arweave-hack/me.png" alt="martin" style="height: 200px;" />
</div>

Martin <martin@openskydevelopment.co.uk>

## Bounties
I am submitting code for both Kwil bounties: **Best use of Kwil** and **Best Kwil Extension**.
For the **Best use of Kwil** track I am submitting two projects: Kwil Admin UI and Kwil DB Sync & Restore.
For the **Best Kwil Extension** track I am submitting 3 extensions.
Further details about each project and their repositories is included below.

# Running Locally
It's very simple to run the Kwil Providers locally.
After cloning this repository, all you need to do is copy the provider-1.env.example to provider-1.env and enter an EVM Private key.  If you would like to run two providers like I demonstrated, repeat the process with provider-2.env.example.

In order to start Kwil Provider 1 run:

    yarn up

In order to start Kwil Provider 2 run:

    yarn up:2

It will take a while the first time all docker images are downloaded.  

If you would like to compile the examples demonstrated in the submission video then they are stored in the *schema* directory.

**When you use the Kuneiform IDE, it's important that the account which is set as the ADMIN_PRIVATE_KEY in the ENV file is the one that deploys schemas.** 
The Sync service and Admin UI assumes only the Admin account will create databases on the Provider.  An IDE will soon be integrated into the Kwil Admin UI, so this will happen automatically once this is completed.

# Admin Tooling
## Kwil Admin UI
The Kwil Admin UI is built using Next.JS and communicates with the local Kwil Provider deployed within the Docker network.  It is a tool to be used by the Kwil DB Administrator only, which means that the account creating all databases remains fixed to the one set in the environment file.  For a full demo please see the submission video, however, some screenshots are included below.

**Repo**: https://github.com/martin-opensky/kwil-admin

The Kwil Provider alias *(Provider 1)*, URL and address are loaded from the information set in the ENV file.  Then all databases are loaded.
<div style="display: flex; justify-content: center;">
<img src="https://lets.embrace.community/arweave-hack/kwil-provider.png" style="height: 400px;" />
</div>

When a DB is selected then all the tables and actions are loaded onto the UI.  The Admin user, can navigate between all the tables in the schema.
<div style="display: flex; justify-content: center;">
<img src="https://lets.embrace.community/arweave-hack/kwil-admin.png" style="height: 350px;" />
</div>

All actions are listed on the right side of the UI, and once clicked an action modal will display allowing the input variables to be entered.

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/kwil-action-list.png" style="height: 200px;" />
</div>
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/kwil-action.png" style="height: 300px;" />
</div>

## Kwil DB Sync & Restore
This tool includes 2 repositories: one is for an extension and the other is for a gRPC server that runs as a container alongside the sync extension.  This tool saves database actions to Arweave (through Bundlr) along with specific tags enabling actions to be easily traced and synced with other Kwil Providers running the service.

**Extension repo**: https://github.com/martin-opensky/kwil-extension-db-sync

**gRPC Server**: https://github.com/martin-opensky/kwil-db-sync-server

When the DB Sync extension is initialised it communicates with the Sync Server to restore any actions that exist on Arweave for that DB ID.  It does this using the Bundlr GraphQL API and the server executes any found actions on the local DB.  This enables actions to be re-played when a server has been taken down or when the schema is re-deployed on another server.

Once the initial actions have been restored, the Sync Server will continue to listen for transactions on the GQL  API.  This enables another Provider to run on a different server and submit actions to the same DB.  By running 2 or more Providers with this service, specific databases can remain synced.  If all Providers were to be destroyed, there is still the option to fully restore the DB, given the permanent storage of actions on Arweave.

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-setup.png" style="height: 200px;" />
</div>

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-function.png" style="height: 300px;" />
</div>

Each action that is synced must have a private equivalent so that the data can be restored by the DB Owner / Admin only.  This is as certain information such as @caller, $date, $id etc could not be replayed successfully at another time by different account.
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-function-owner.png" style="height: 100px;" />
</div>

Once the save_action method is called on the extension the data is saved to Arweave and can be found through the Bundlr GQL API.
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-tags.png" style="height: 400px;" />
</div>

The file stored on Arweave contains information about which action to run and what parameters to use:
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-json.png" style="height: 400px;" />
</div>

Another server can deploy the same schema and remain in sync with the original DB by supplying the ID when registering the extension:
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/sync-function-2.png" style="height: 120px;" />
</div>

# Extensions
## Full DB Schema and Data Backup
This extension enables the Admin to run a full schema and data backup of the database to Arweave.

**Repo:** https://github.com/martin-opensky/kwil-extension-db-export

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/export-ext.png" style="height: 60px;" />
</div>

<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/export-function.png" style="height: 150px;" />
</div>

Backups can be easily tracked using the Arweave tags:
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/export-gql.png" style="height: 400px;" />
</div>

The full DB schema, including tables and actions are stored, along with the data for each table.
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/export-json.png" style="height: 400px;" />
</div>

## Helpers Extension
This extension provides helpers to the actions to simplify important functions such as creating unique Ids and dates.  Additional methods can also be added to extend the functions available, but for now only 2 exist.

**Repo:** https://github.com/martin-opensky/kwil-extension-helpers

### helper.id()
Without this function, an Id has to be supplied to each action that inserts data to a table.  This makes tracking unique Id's more complicated than it needs to be.  By using this method, we can be sure that the Id will be unique without having to create one prior to executing the action.  This uses nanoid() to ensure a universally unique ID is generated.

### helper.date()
This enables dates to be automatically created within the action.  It currently only supports 'now' but could easily be expanded to add support for other date strings. e.g '+ 1 day', '+ 1 week' etc

Before using the helpers both id's and date's have to be constructed before calling the action:
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/helper-before.png" style="height: 120px;" />
</div>

With the helper methods these values are created automatically, and only the $message parameter needs to be provided.
<div style="display: flex; justify-content: space-between;">
<img src="https://lets.embrace.community/arweave-hack/helper-after.png" style="height: 200px;" />
</div>