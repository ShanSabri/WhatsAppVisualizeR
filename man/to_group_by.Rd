% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/analysis.R
\name{to_group_by}
\alias{to_group_by}
\title{Helper function to determine if query should be grouped by
user and/or date}
\usage{
to_group_by(x, by_user = TRUE)
}
\arguments{
\item{x}{a \code{tibble} of WhatsApp chat data}

\item{by_user}{a boolean flag to indicate if query should be grouped by user}
}
\value{
a grouped \code{tibble} of WhatsApp chat data
}
\description{
Helper function to determine if query should be grouped by
user and/or date
}
