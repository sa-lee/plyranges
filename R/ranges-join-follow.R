# ranges-join-follow.R

#' Find following Ranges
#'
#' @param x,y Ranges objects, which ranges in x follow those in y.
#'
#' @details By default \code{join_follow} will find abritrary ranges
#' in y that are followed by ranges in x and ignore any strand information.
#'
#' @return A Ranges object with a metadata column called follow that
#' contains the corresponding Ranges that is follows the ranges x.
#' @rdname follow-ranges
#' @importFrom IRanges follow
#' @export
join_follow <- function(x,y) { UseMethod("join_follow") }

#' @export
join_follow.Ranges <- function(x,y) {
  hits <- follow(x,y)
  nearest_rng(x,y,hits, type = "follows")
}

#' @export
join_follow.GenomicRanges <- function(x,y) {
  hits <- follow(x,y, ignore.strand = TRUE)
  nearest_rng(x,y, hits, type = "follows")
}

# does follow left/right make sense? follow will always be left...
# likewise follow will produce ranges upstream

#' Find all preceding Ranges
#'
#' @param x,y Ranges objects, which ranges y follow those on x.
#'
#' @details By definition,  \code{join_follow_left} will find all ranges in y
#' that are on the left-hand side of the ranges in x ignoring any strand
#' information.
#'
#' @return A Ranges object with a metadata column called follows that
#' contains the corresponding Ranges that is follows the ranges x.
#' @rdname follow-ranges
#' @importFrom IRanges follow
#' @export
join_follow_left <- function(x,y) { UseMethod("join_follow_left") }

#' @export
join_follow_left.Ranges <- function(x,y) {
  hits <- follow(x,y, select = "all")
  nearest_rng_all(x,y, hits, type = "follows")
}

#' @export
join_follow_left.GenomicRanges <- function(x,y) {
  hits <- follow(x,y, select = "all", ignore.strand = TRUE)
  nearest_rng_all(x,y, hits, type = "follows")
}

#' Find all preceding Ranges upstream
#'
#' @param x,y Ranges objects, which ranges y follow those on x.
#'
#' @details By definition,  \code{join_follow_left} will find all ranges in y
#' that are that are upstream of the ranges in x. On the positive strand this
#' will result in ranges in y that are left of those in x and on the negative
#' strand it will result in ranges in y that left of those in x.
#'
#' @return A Ranges object with a metadata column called follows that
#' contains the corresponding Ranges that is follows the ranges x.
#' @rdname follow-ranges
#' @importFrom IRanges follow
#' @export
join_follow_upstream <- function(x,y) {UseMethod("join_follow_upstream")}

#' @export
join_follow_upstream.GenomicRanges <- function(x,y) {
  hits <- follow(x,y, select = "all", ignore.strand = FALSE)
  nearest_rng_all(x, y, hits, type = "follows")
}