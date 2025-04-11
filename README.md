# n8n-heroku with Neon Database Support

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://dashboard.heroku.com/new?template=https://github.com/boazde/n8n-heroku/tree/main)

## n8n - Free and open fair-code licensed node based Workflow Automation Tool.

This is a [Heroku](https://heroku.com/)-focused container implementation of [n8n](https://n8n.io/) with support for [Neon Database](https://neon.tech/).

## Deployment Options

### Option 1: Deploy with Heroku Postgres (Default)
Use the **Deploy to Heroku** button above to launch n8n on Heroku with the default Heroku Postgres database. When deploying, make sure to check all configuration options and adjust them to your needs. It's especially important to set `N8N_ENCRYPTION_KEY` to a random secure value.

### Option 2: Deploy with Neon Database
1. First, create a Neon database instance at [https://neon.tech](https://neon.tech)
2. Get your connection string from the Neon dashboard
3. Use the **Deploy to Heroku** button above
4. In the deployment form, paste your Neon connection string into the `NEON_DATABASE_URL` field
5. Make sure to set `N8N_ENCRYPTION_KEY` to a random secure value
6. Complete the deployment process

Refer to the [Heroku n8n tutorial](https://docs.n8n.io/hosting/server-setups/heroku/) for more information on basic Heroku deployment.

## Why Use Neon Database?
- **Better Free Tier**: Neon offers a more generous free tier compared to Heroku Postgres
- **Auto-scaling**: Neon provides serverless PostgreSQL that scales to zero when not in use
- **Branching**: Easily create database branches for testing and development
- **Advanced Features**: Includes point-in-time recovery, logical replication, and more

If you have questions after trying the tutorials, check out the [forums](https://community.n8n.io/).