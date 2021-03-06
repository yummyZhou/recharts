#' Create an axis for a chart
#'
#' Add an axis to a chart.
#'
#' This function modified a few default options for the axis component in
#' ECharts: 1) \code{scale = TRUE} (was \code{FALSE} by default in ECharts); 2)
#' \code{axisLine$onZero = FALSE} (was \code{TRUE} in ECharts).
#' @export
#' @rdname axis
eAxis = function(
  chart, which = c('x', 'y'),
  type = c('value', 'category', 'time'), show = TRUE,
  position = c('bottom', 'top', 'left', 'right'),
  name = '', nameLocation = c('end', 'start'), nameTextStyle = emptyList(),
  boundaryGap = c(0, 0), min = NULL, max = NULL, scale = TRUE, splitNumber = NULL,
  axisLine = list(show = TRUE, onZero = FALSE), axisTick = list(show = FALSE),
  axisLabel = list(show = TRUE), splitLine = list(show = TRUE),
  splitArea = list(show = FALSE), data = list()
) {
  which = match.arg(which)
  if (missing(type)) type = axisType(getMeta(chart)[[which]], which)
  if (missing(position)) position = if (which == 'x') 'bottom' else 'left'

  x = chart$x
  i = paste0(which, 'Axis')
  o = list(
    type = match.arg(type), show = show, position = match.arg(position),
    name = name, nameLocation = match.arg(nameLocation), nameTextStyle = nameTextStyle,
    boundaryGap = boundaryGap, min = min, max = max, scale = scale,
    splitNumber = splitNumber, axisLine = axisLine, axisTick = axisTick,
    axisLabel = axisLabel, splitLine = splitLine, splitArea = splitArea, data = data
  )
  x[[i]] = mergeList(x[[i]], o)
  chart$x = x

  chart
}

#' @export
#' @rdname axis
eXAxis = function(chart, position = 'bottom', ...) {
  eAxis(chart, position = position, ...)
}

#' @export
#' @rdname axis
eYAxis = function(chart, position = 'left', ...) {
  eAxis(chart, position = position, ...)
}

axisType = function(data, which = c('x', 'y')) {
  if (is.numeric(data)) return('value')
  if (is.factor(data) || is.character(data)) return('category')
  if (inherits(data, 'Date')) return('time')
  message('The structure of the ', which, ' variable:')
  str(data)
  stop('Unable to derive the axis type automatically from the ', which, ' variable')
}
