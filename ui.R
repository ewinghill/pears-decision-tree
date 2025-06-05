ui <- dashboardPage(
  skin = "red",
  dashboardHeader(
    title = tags$span(
      "PEARS Engage Decision Tool",
      style = "white-space: normal; font-size: 18px; font-weight: bold; color: white;"
    )
  ),
  
  dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("Engage Overview", tabName = "overview", icon = icon("info-circle")),
                menuItem("Decision Tree", tabName = "tree", icon = icon("sitemap")),
                br(),
                actionButton("restart", "Start Over", class = "custom-grey-button")
    )
  ),
  
  dashboardBody(
    tags$head(
      tags$title("PEARS Engage Decision Tool"),
      tags$style(HTML("
        #restart.custom-grey-button {
          background-color: #E2E9EB !important;
          color: #0C234B !important;
          font-size: 18px !important;
          padding: 14px 28px !important;
          border: none !important;
          width: 100%;
          margin-top: 15px;
        }
        #restart.custom-grey-button:hover {
          background-color: #d4dce0 !important;
        }

        body, .content {
          font-family: system-ui, sans-serif;
          font-size: 16px;
        }

        .skin-red .main-header .navbar,
        .skin-red .main-header .logo,
        .skin-red .main-header .logo:hover {
          background-color: #0C234B !important;
          color: white !important;
        }

        .skin-red .main-sidebar {
          background-color: #0C234B !important;
          color: white !important;
        }

        .skin-red .main-sidebar .sidebar a {
          color: white !important;
        }

        .box.box-solid.box-primary > .box-header {
          background-color: #0C234B !important;
          color: white !important;
        }

        .btn-default {
          background-color: #0C234B !important;
          color: white !important;
          border-color: #0C234B !important;
          font-size: 18px !important;
          padding: 14px 28px !important;
        }

        .btn-default:hover {
          background-color: #18375F !important;
        }

        .content-wrapper, .right-side {
          background-color: #E2E9EB;
        }

        .box.box-solid.box-primary {
          background-color: white !important;
        }

        .subheading {
          font-size: 18px;
          margin-bottom: 20px;
          color: #333;
        }

        .result-highlight {
          font-size: 28px;
          font-weight: bold;
          color: #AB0520;
          margin-top: 10px;
          margin-bottom: 10px;
        }

        .module-box {
          padding: 16px;
          margin-bottom: 16px;
          border-radius: 8px;
          color: black;
          font-size: 16px;
        }

        .green { background-color: #d0ebd0; }
        .blue { background-color: #d0e9f5; }
        .yellow { background-color: #fef3c0; }
        .teal { background-color: #d1f1ef; }
        .purple { background-color: #e8ddf5; }
        .gray { background-color: #eeeeee; }
        .red { background-color: #f6d1d1; }
      "))
    ),
    
    tabItems(
      tabItem(
        tabName = "overview",
        box(
          width = 12, status = "primary", solidHeader = TRUE,
          title = "What counts as Engage programming?",
          div(class = "subheading",
              "The Engage module in PEARS tracks programming data across several categories. 
               Use the summaries below to find the best match for your data type."),
          actionButton("jump_to_tree", "Not sure? Use the Decision Tree →", class = "btn btn-default", style = "margin-bottom: 24px;")
        ),
        fluidRow(
          box(width = 12, class = "module-box green",
              h4("Program Activities"),
              tags$ul(
                tags$li("Workshops, classes, or series with educational content lasting 20+ minutes."),
                tags$li("E.g., Cooking Matters, diabetes prevention classes.")
              )
          ),
          box(width = 12, class = "module-box blue",
              h4("Indirect Activities"),
              tags$ul(
                tags$li("Distribution of educational materials or short presentations (<20 min)."),
                tags$li("E.g., health fair booths, newsletters, flyers.")
              )
          ),
          box(width = 12, class = "module-box yellow",
              h4("Direct Contacts"),
              tags$ul(
                tags$li("One-on-one educational interactions."),
                tags$li("E.g., home visits, in-person or phone consultations.")
              )
          ),
          box(width = 12, class = "module-box teal",
              h4("Partnerships"),
              tags$ul(
                tags$li("Collaboration with a single organization."),
                tags$li("E.g., planning meetings or joint implementation with one group.")
              )
          ),
          box(width = 12, class = "module-box purple",
              h4("Coalitions"),
              tags$ul(
                tags$li("Multi-organization partnerships or task forces."),
                tags$li("E.g., school wellness coalitions, multi-agency advisory boards.")
              )
          ),
          box(width = 12, class = "module-box gray",
              h4("CRM (Community Relationships)"),
              tags$ul(
                tags$li("Informal interactions that help maintain relationships."),
                tags$li("E.g., stopping by a partner’s office, community events.")
              )
          ),
          box(width = 12, class = "module-box red",
              h4("Social Marketing"),
              tags$ul(
                tags$li("Mass media campaigns with a call to action."),
                tags$li("E.g., billboards, radio PSAs, social media pushes.")
              )
          )
        ),
        
        box(
          width = 12, status = "primary", solidHeader = TRUE, title = "What do I do next?",
          div(class = "subheading", "Entering your data in PEARS:"),
          tags$ol(
            tags$li("Go to ", a(href = "https://pears.io", "https://pears.io", target = "_blank")),
            tags$li("Type in your UA email address"),
            tags$li("Click outside the box. You will be redirected to the UA single sign-on login page"),
            tags$li("Click Engage at the top of the PEARS homepage"),
            tags$li("Select the recommended module (for example, Indirect Activities or Program Activities)"),
            tags$li("Complete the form with your activity details")
          ),
          br(),
          div(class = "subheading", "If you are not sure what to enter:"),
          tags$ul(
            tags$li("Email ", a(href = "mailto:support@pears.io", "support@pears.io")),
            tags$li("You can also reach out to:"),
            tags$ul(
              tags$li("Amy Hoffman | ", a(href = "mailto:hoffman9@arizona.edu", "hoffman9@arizona.edu")),
              tags$li("Terrace Ewinghill | ", a(href = "mailto:terrace@arizona.edu", "terrace@arizona.edu"))
            ),
            tags$li("Use the built-in Support and Resources feature in the top-right of the PEARS screen"),
            tags$li("Or talk to your supervisor")
          )
        )
      ),
      
      tabItem(
        tabName = "tree",
        box(
          width = 12, status = "primary", solidHeader = TRUE,
          title = "PEARS Engage Decision Tree",
          div(class = "subheading", "Answer a series of questions to determine which Engage module is best for your data type."),
          uiOutput("question_ui"),
          uiOutput("result_ui")
        )
      )
    )
  )
)
