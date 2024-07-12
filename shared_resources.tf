resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_password" "password" {
  count   = var.vm_count
  length  = 16
  special = true
  numeric = true
  upper   = true
  lower   = true
}

resource "azurerm_key_vault" "main" {
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  name                     = "${var.resource_group_name}-keyvault"
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  purge_protection_enabled = false

  depends_on = [
    azurerm_resource_group.main
  ]
}

resource "azurerm_key_vault_access_policy" "user_access" {
  depends_on = [azurerm_key_vault.main]
  for_each   = var.owner_details

  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = each.value.object_id
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Backup",
    "Restore",
    "Recover",
    "Purge"
  ]

  key_permissions = [
    "Get",
    "List",
    "Create",
    "Import",
    "Update",
    "Delete",
    "Backup",
    "Restore",
    "Recover",
    "Purge",
    "Encrypt",
    "Decrypt",
    "UnwrapKey",
    "WrapKey",
    "Verify",
    "Sign"
  ]

  certificate_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "ManageContacts",
    "ManageIssuers",
    "GetIssuers",
    "ListIssuers",
    "SetIssuers",
    "DeleteIssuers",
    "Purge"
  ]
}
