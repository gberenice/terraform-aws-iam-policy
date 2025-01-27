variable "region" {
  description = "AWS region"
}

variable "iam_policy" {
  type = object({
    policy_id = optional(string, null)
    version   = optional(string, null)
    statements = list(object({
      sid           = optional(string, null)
      effect        = optional(string, null)
      actions       = optional(list(string), null)
      not_actions   = optional(list(string), null)
      resources     = optional(list(string), null)
      not_resources = optional(list(string), null)
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), [])
      not_principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), [])
    }))
  })
  description = <<-EOT
    IAM policy as Terraform object, compatible with `aws_iam_policy_document` except
    that `source_policy_documents` and `override_policy_documents` are not included.
    Use inputs `iam_source_policy_documents` and `iam_override_policy_documents` for that.
    Conflicts with `iam_policy_statements`.
    This can be used with or instead of the `var.iam_source_json_url`.
    EOT
  default     = null
}

variable "iam_policy_statements" {
  type = map(object({
    sid           = optional(string, null)
    effect        = optional(string, null)
    actions       = optional(list(string), null)
    not_actions   = optional(list(string), null)
    resources     = optional(list(string), null)
    not_resources = optional(list(string), null)
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })), [])
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
  }))
  description = <<-EOT
    Deprecated: use `iam_policy` instead.
    Map of IAM policy statements to use in the policy. Conflicts with `iam_policy`.
    This can be used with or instead of the `var.iam_source_json_url`.
    EOT
  default     = null
}

variable "iam_source_json_url" {
  type        = string
  description = <<-EOT
    URL of the IAM policy (in JSON format) to download and use as `source_json` argument.
    This is useful when using a 3rd party service that provides their own policy.
    This can be used with or instead of `var.iam_policy`.
    EOT
  default     = null
}
