## Main
variable "location" {
    type = string
    default = "UK South"
}
variable "resource_group" {
    type = string
}

## Storage
variable "storage" {
  type = string
}

## App Insights
variable "appinsights" {
  type = string
}

## Function
variable "asp" {
  type = string
}

variable "fa" {
  type = string
}

## KV
variable "keyvault" {
  type = string
}
