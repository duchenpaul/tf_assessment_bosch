tenant_id = "335836de-42ef-43a2-b145-348c2ee9ca5b"


# Adding Users here may grant privileged access to azure resources
# Object ID can be found: "az ad user show --id charles.knight@citrix.com --query objectId --out tsv
owner_details = {
  "chend" = {
    object_id = "4426dbc0-bfee-4a42-b6ad-b5c88eb3422f"
    pubkey    = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAwwwZQ5ivSxGOiglLVf+mEmF4yv/H59keNZcyiGlToEfbwA7EaH4trhllc3H+EYy2IV/0rCmxPGTDFAaYwwfSykPUm2xGFcM1ESUE7ywWQesa2mf8ITmBy8Uk11QyFcafzG+rPy3fVUf0d75+0qAQ5MtQ0QEpsfk0Y9PtRL1HyeW917cOcZOvlbkj6B2Mh/cH8X3AzqU50sd0vihNKDxM20r2cUUr0roHL9+rVYuNi2yz8mlFQlNzob1z375OAYdUVf/SkPdZbVr0S7qcEfU6huuXNJOQU0hbRFh2fTz/oUYfWlo27l5J2JsoLxzCX4iMbWiwHFBnNy0CJaOOaGjwI2ZutF1fXlG0Wuda7lBsd3uZIX8JlCz14w8UkfYUY+GVS+g9Tnv/6uBnFo80w68wfRCV9CjIExPO6Zzt2u+ObWcPolZQ+f2DtCpZ/ttbxrSqMDkwJ1c6mWHQtXqeclp4dyUzGzHWEdy+bCGUEQMbC+wWKaX8Djj+6N2134uwcR51vSOc0K2PUIOcPsA4F7RvwClG6QtjJFTPMXk1h92wyJiP24byPMpZOUu4RiedvTzVLfe20ye3NOF2RPUER+2cVuXOCqNoeDX0WAvjg10IMOU0VsZj1U296BjuIpID61fdWkTj/HLQcRfbVUD2ko7OtGbu2VevFCVMcNO/QiQZoB8= chen.du@citrix.com"
    path      = "/home/azureuser/.ssh/authorized_keys"
  }
}

private_key_path = "/home/chend/.ssh/id_rsa_citrix"

vnet_use_existing = true

resource_group_name = "chend-rg"
location            = "northeurope"
vm_count            = 3
vm_size             = "Standard_B1s"
# vm_image            = "0001-com-ubuntu-server-jammy"
# vm_sku              = "20_04-lts"
admin_username = "azureuser"
