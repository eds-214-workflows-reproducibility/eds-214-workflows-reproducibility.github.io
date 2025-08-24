# Originally generated with Claude AI
create_schedule_table <- function(day = NA) {
  # Define the schedule data
  days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
  
  am_activities <- c(
    "Reproducible workflows",
    "Plan an analysis", 
    "Command line and remote server",
    "Navigate the server",
    "Version control with git",
    "git branching",
    "Draft Quarto analysis",
    "Self assessment",
    "Meet your next instructor",
    "Final project submission"
  )
  
  pm_activities <- c(
    "Workflow organization",
    "Make spaghetti",
    "Documen-tation",
    "READMEs, comments, and style", 
    "Collaboration with GitHub",
    "Refactor a function",
    "Peer feedback and contributions",
    "Open work time",
    "Instructor feedback",
    "Project wrap-up"
  )
  
  # Create HTML table
  html <- '
<style>
  .reveal .schedule-table {
    font-family: "Nunito", sans-serif;
    border-collapse: collapse;
    width: 100% !important;
    max-width: 100% !important;
    table-layout: fixed;
    font-size: 14px !important;
  }
  
  .reveal .schedule-table td, .reveal .schedule-table th {
    padding: 6px 4px !important;
    text-align: left !important;
    vertical-align: middle;
    word-wrap: break-word;
    overflow-wrap: break-word;
    font-size: 14px !important;
  }
  
  .day-header {
    font-weight: bold;
    text-align: center !important;
  }
  
  .lecture-interactive-row {
    text-align: center !important;
  }
  
  .no-border {
    border: none !important;
    border-bottom: none !important;
    border-top: none !important;
    border-left: none !important;
    border-right: none !important;
  }
  
  .no-border td {
    border: none !important;
    border-bottom: none !important;
    border-top: none !important;
    border-left: none !important;
    border-right: none !important;
  }
  
  .time-label {
    font-weight: bold;
    width: 30px;
  }
  
  .lecture-cell {
    background-color: #d2e3f3;
  }
  
  .row-border-thick {
    border-bottom: 3px solid #047C90;
  }
  
  .row-border-thin {
    border-bottom: 1px solid #047C90;
  }
  
  .highlight-day {
    border: 6px solid #78A540;
  }
</style>

<table class="schedule-table">
  <colgroup>
    <col style="width: 40px;">
    <col span="10">
  </colgroup>
  <tr class="no-border">
    <td></td>'
  
  # Add day headers (2 cells wide each)
  for (i in 1:length(days)) {
    day_class <- if (!is.na(day) && i == day) 'day-header highlight-day' else 'day-header'
    html <- paste0(html, '\n    <td colspan="2" class="', day_class, '">', days[i], '</td>')
  }
  
  html <- paste0(html, '\n  </tr>')
  
  # Add Lecture/Interactive row
  html <- paste0(html, '\n  <tr class="row-border-thick">')
  html <- paste0(html, '\n    <td></td>')
  
  for (i in 1:5) {
    html <- paste0(html, '\n    <td class="lecture-interactive-row">Lecture</td>')
    html <- paste0(html, '\n    <td class="lecture-interactive-row">Interactive</td>')
  }
  
  html <- paste0(html, '\n  </tr>')
  
  # Add AM row
  html <- paste0(html, '\n  <tr class="row-border-thin">')
  html <- paste0(html, '\n    <td class="time-label">AM</td>')
  
  for (i in 1:5) {
    am_idx <- (i-1)*2 + 1
    lecture_class <- if (!is.na(day) && i == day) 'lecture-cell highlight-day' else 'lecture-cell'
    interactive_class <- if (!is.na(day) && i == day) 'highlight-day' else ''
    
    html <- paste0(html, '\n    <td class="', lecture_class, '">', am_activities[am_idx], '</td>')
    html <- paste0(html, '\n    <td class="', interactive_class, '">', am_activities[am_idx + 1], '</td>')
  }
  
  html <- paste0(html, '\n  </tr>')
  
  # Add PM row
  html <- paste0(html, '\n  <tr>')
  html <- paste0(html, '\n    <td class="time-label">PM</td>')
  
  for (i in 1:5) {
    pm_idx <- (i-1)*2 + 1
    lecture_class <- if (!is.na(day) && i == day) 'lecture-cell highlight-day' else 'lecture-cell'
    interactive_class <- if (!is.na(day) && i == day) 'highlight-day' else ''
    
    html <- paste0(html, '\n    <td class="', lecture_class, '">', pm_activities[pm_idx], '</td>')
    html <- paste0(html, '\n    <td class="', interactive_class, '">', pm_activities[pm_idx + 1], '</td>')
  }
  
  html <- paste0(html, '\n  </tr>')
  html <- paste0(html, '\n</table>')
  
  return(html)
}

# Example usage:
# schedule_html <- create_schedule_table()        # No highlighting
# schedule_html <- create_schedule_table(day = 3) # Highlight Wednesday
# cat(schedule_html)