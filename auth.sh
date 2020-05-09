#!/bin/sh
echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID=69fa2b01-430e-405c-a55d-1b6dcb7ae43b
export ARM_CLIENT_ID=${{ secrets.AZURE_CLIENT_ID }}
export ARM_CLIENT_SECRET=${{ secrets.AZURE_CLIENT_SECRET }}
export ARM_TENANT_ID=bouvetasa.onmicrosoft.com