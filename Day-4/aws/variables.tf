# 1️⃣ STRING
variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "centralindia"
}

# 2️⃣ NUMBER
variable "disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
  default     = 30
}

# 3️⃣ BOOLEAN
variable "enable_public_ip" {
  description = "Whether to create a public IP for the VM"
  type        = bool
  default     = true
}

# 4️⃣ LIST
variable "subnet_prefixes" {
  description = "Subnet address ranges"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

# 5️⃣ MAP
variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default = {
    Project = "Day4-All-Var-POC"
    Owner   = "Bavi"
  }
}

# 6️⃣ SENSITIVE
variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  sensitive   = true  
}

variable "client_id" {
  type        = string
  description = "Azure Service Principal Client ID"
  sensitive   = true
}

variable "client_secret" {
  type        = string
  description = "Azure Service Principal Client Secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
  sensitive   = true
}

variable "admin_password" {
  type        = string
  description = "Azure password"
  sensitive   = true    
}