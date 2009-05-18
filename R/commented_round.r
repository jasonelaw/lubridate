# Rounding for dates
# ---------------------------------------------------------------------------

floor_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year"), eps=1e-10) {

  # matching user's input for "unit" to type of unit indicated
  unit <- match.arg(unit)
  
  # Note: Is this so a time less than 1e-10 second below a unit is floored to 
  #   the unit below and not recognized as equal to the first unit? 
  if (unit != "second") second(x) <- second(x) - eps 

  # selecting appropriate task based on user's input for "unit"
  switch(unit,
  
    # Note: How does this work? Does R automatically execute
    # > second(x) <- 0
    # as
    # > second<-(x, 0)? 
    # If not, could we use this to simplify the update.Date function?
    second = {second(x) <- floor(second(x));},
    minute = {second(x) <- 0;},
    hour =   {minute(x) <- 0; second(x) <- 0;},
    day =    {hour(x) <- 0; minute(x) <- 0; second(x) <- 0},
    week =   {wday(x) <- 1; hour(x) <- 0; minute(x) <- 0; second(x) <- 0},
    month =  {mday(x) <- 1; hour(x) <- 0; minute(x) <- 0; second(x) <- 0},
    year =   {yday(x) <- 1; hour(x) <- 0; minute(x) <- 0; second(x) <- 0}
  )
  
  # returning floored date
  x
}


# In almost the same manner as above...
ceiling_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year"), eps=1e-10) {
  unit <- match.arg(unit)
  if (unit != "second") second(x) <- second(x) + eps 
  
  # we now add 1 to the desired unit and then floor it
  switch(unit,
    second = second(x) <- ceiling(second(x)),
    minute = minute(x) <- minute(x) + 1,
    hour =   hour(x) <- hour(x) + 1,
    day =    yday(x) <- yday(x) + 1,
    week =   week(x) <- week(x) + 1,
    month =  month(x) <- month(x) + 1,
    year =   year(x) <- year(x) + 1
  )
  
  # Note: Why is the eps now 0?
  floor_date(x, unit, eps=0)
}

# round the date to whichever is closer: its floored value or ceiling value
round_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year")) {
  below <- floor_date(x, unit)
  above <- ceiling_date(x, unit)
  
  # If the difference in seconds between the date and its floor is less than the 
  #   difference between the date and its ceiling, return the floor. Otherwise, 
  #   return the ceiling.
  
  # structure( , class = "POSIXct") attaches a class attribute that identifies 
  #   this as a POSIXct object
  structure(ifelse(difftime(x, below, "secs") < difftime(above, x, "secs"), below, above), class="POSIXct")
}

