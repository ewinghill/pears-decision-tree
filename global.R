# global.R

library(shiny)
library(shinydashboard)
library(glue)
library(DiagrammeR)

questions <- list(
  q1 = list(
    text = "Was this an activity intended to reach an external audience?",
    help = "This includes education provided in-person or online, one-on-one or to groups, as well as passive outreach like flyers, booths, newsletters, or media campaigns.",
    options = list(Yes = "q1b", No = "r_skip")
  ),
  q1b = list(
    text = "Was this part of an ongoing strategy, like a PSE Site Activity or Social Marketing Campaign?",
    help = "These efforts include coordinated, long-term strategies like policy, systems, and environmental changes or broad public awareness campaigns.",
    options = list(Yes = "q1c", No = "q2")
  ),
  q1c = list(
    text = "Which type of ongoing strategy was it?",
    help = "Select the category that best fits this activity.",
    options = list(
      "PSE Site Activity" = "r_pse",
      "Social Marketing Campaign" = "r_social"
    )
  ),
  q2 = list(
    text = "Was it a one-on-one educational interaction?",
    help = "This means personalized education or consultation, such as answering a question in person, by phone, or online.",
    options = list(Yes = "q2b", No = "q3")
  ),
  q2b = list(
    text = "Do you want to track this one-on-one contact in more detail?",
    help = "Select Yes if you're using the CRM module to log individual interactions (e.g., phone calls, emails, visits) with added context.",
    options = list(Yes = "r_crm", No = "r_direct")
  ),
  q3 = list(
    text = "Did you provide group education lasting 20 minutes or more?",
    help = "Examples: workshops, classes, or series where you provided structured educational content.",
    options = list(Yes = "r_program", No = "q4")
  ),
  q4 = list(
    text = "Was this activity mainly about sharing information or materials, without planning or working together with the group?",
    help = "Examples: presenting at a booth, giving a short update to a board, distributing flyers. If you coordinated or planned the activity with others, choose No.",
    options = list(Yes = "r_indirect", No = "q5")
  ),
  q4b = list(
    text = "Was this part of a coordinated Social Marketing campaign?",
    help = "Coordinated campaigns involve strategy, multiple methods, and often multiple partners. Examples: billboards, radio PSAs, coordinated social media pushes.",
    options = list(Yes = "r_social", No = "r_indirect")
  ),
  q5 = list(
    text = "Was this activity with a single organization you regularly work with?",
    help = "Examples: meeting with a school you partner with to plan programs or share updates.",
    options = list(Yes = "r_partnership", No = "q6")
  ),
  q6 = list(
    text = "Was this a collaboration between multiple organizations?",
    help = "Examples: wellness coalitions, community advisory groups, or inter-agency meetings.",
    options = list(Yes = "r_coalition", No = "r_skip")
  ),
  q7 = list(
    text = "Was this a site-level policy, systems, or environmental change?",
    help = "Examples: creating a school garden, updating a site’s wellness policy, posting signage to encourage healthy behaviors.",
    options = list(Yes = "r_pse", No = "r_skip")
  )
  
)


results <- list(
  r_direct = list(label = "Direct Contacts", required = TRUE),
  r_program = list(label = "Program Activities", required = TRUE),
  r_indirect = list(label = "Indirect Activities", required = TRUE),
  r_partnership = list(label = "Partnerships", required = TRUE),
  r_coalition = list(label = "Coalitions", required = TRUE),
  r_crm = list(label = "CRM (Optional)", required = FALSE),
  r_skip = list(label = "Outside Engage\n(Consider Reflect)", required = FALSE),
  r_pse = list(label = "PSE Site Activities", required = TRUE),
  r_social = list(label = "Social Marketing", required = FALSE)

)
