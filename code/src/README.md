## Infra set up of the AI-FAST App using terraform

- please run main.tf file in your gcp project by replacing project value with your gcp project
- Run terraform init
- Run terraform fmt
- Run terraform plan
- Once plan is successful run terraform apply


## Application Setup

1.  **Clone the Repository**

2.  **Place your Dialogflow Messenger code into `index.html`:**

    Replace the contents of `index.html` with your Dialogflow Messenger HTML code, making sure to update the `project-id` and `agent-id` with your Dialogflow agent's details.

3.  **Create the `Dockerfile`:**

4.  **Build and Push the Docker Image:**

    Build the Docker image:

    ```bash
    docker build -t dialogflow-messenger-cloudrun .
    ```

    Tag the image for Google Container Registry (GCR):

    ```bash
    docker tag dialogflow-messenger-cloudrun gcr.io/[YOUR_PROJECT_ID]/dialogflow-messenger-cloudrun
    ```

    (Replace `[YOUR_PROJECT_ID]` with your Google Cloud project ID.)

    Push the image to GCR:

    ```bash
    docker push gcr.io/[YOUR_PROJECT_ID]/dialogflow-messenger-cloudrun
    ```

5.  **Deploy to Cloud Run:**

    Deploy the image to Cloud Run:

    ```bash
    gcloud run deploy hackathon-webui-ipe \
        --image gcr.io/[YOUR_PROJECT_ID]/dialogflow-messenger-cloudrun \
        --platform managed \
        --region us-central1 \
        --allow-unauthenticated
    ```

    * Replace `hackathon-webui-ipe` with the desired service name.
    * Ensure the `--region` matches your Dialogflow agent's location.
    * Remove `--allow-unauthenticated` if you require authentication.

6.  **Access the Deployed Service:**

    After deployment, Cloud Run will provide a URL. Access this URL in your web browser to interact with the Dialogflow Messenger chatbot.
