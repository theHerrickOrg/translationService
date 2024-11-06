const axios = require('axios');

module.exports = async function (context, req) {
    context.log('HTTP trigger function processed a request.');

    // Extract parameters from the request body
    const { applicationname, resource_group, location } = req.body;

    if (!applicationname || !resource_group || !location) {
        context.res = {
            status: 400,
            body: "Missing required parameters: 'applicationname', 'resource_group', or 'location'."
        };
        return;
    }

    // GitHub repository information from environment variables
    const githubToken = process.env.GITHUB_TOKEN;
    const githubOwner = process.env.GITHUB_OWNER;
    const githubRepo = process.env.GITHUB_REPO;
    const workflowId = process.env.GITHUB_WORKFLOW_ID;

    const githubApiUrl = `https://api.github.com/repos/${githubOwner}/${githubRepo}/actions/workflows/${workflowId}/dispatches`;

    try {
        // Trigger the GitHub Actions workflow with the specified inputs
        const response = await axios.post(
            githubApiUrl,
            {
                ref: 'main',  // Set the branch you want to run the workflow on
                inputs: {
                    applicationname,
                    resource_group,
                    location
                }
            },
            {
                headers: {
                    Authorization: `Bearer ${githubToken}`,
                    Accept: 'application/vnd.github.v3+json'
                }
            }
        );

        context.res = {
            status: 200,
            body: `Workflow triggered successfully with response: ${response.statusText}`
        };
    } catch (error) {
        context.log.error('Error triggering workflow:', error);

        context.res = {
            status: error.response ? error.response.status : 500,
            body: `Failed to trigger workflow: ${error.message}`
        };
    }
};
