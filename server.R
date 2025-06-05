server <- function(input, output, session) {
  # Track the current decision tree state
  state <- reactiveValues(
    current = "q1",
    path = character(),
    final = NULL,
    steps = list()
  )
  
  # Reset state when switching to the decision tree tab
  observeEvent(input$tabs, {
    if (input$tabs == "tree") {
      state$current <- "q1"
      state$path <- character()
      state$final <- NULL
      state$steps <- list()
    }
  })
  
  # Also allow reset with the Start Over button
  observeEvent(input$restart, {
    state$current <- "q1"
    state$path <- character()
    state$final <- NULL
    state$steps <- list()
  })
  
  # Capture Yes/No responses
  lapply(c("Yes", "No"), function(choice) {
    observeEvent(input[[paste0("answer_", choice)]], {
      req(state$current)
      next_node <- questions[[state$current]]$options[[choice]]
      
      # Safeguard against unexpected values
      if (!(next_node %in% names(questions)) && !(next_node %in% names(results))) {
        showNotification("Internal logic error: next_node not defined.", type = "error")
        return()
      }
      
      state$path <- c(state$path, state$current, next_node)
      state$steps[[length(state$steps) + 1]] <- list(q = state$current, a = choice)
      
      if (startsWith(next_node, "r_")) {
        state$final <- next_node
      } else {
        state$current <- next_node
      }
    }, ignoreInit = TRUE)
  })
  
  # Render the current question UI
  output$question_ui <- renderUI({
    req(!is.null(state$current))
    req(is.null(state$final))
    
    q <- questions[[state$current]]
    tagList(
      h3(q$text),
      actionButton("answer_Yes", "Yes"),
      actionButton("answer_No", "No")
    )
  })
  
  # Render the final result and decision tree
  output$result_ui <- renderUI({
    req(!is.null(state$final))
    res <- results[[state$final]]
    req(!is.null(res))
    
    tagList(
      h3("Recommended Module:"),
      div(
        style = "font-size: 28px; font-weight: bold; color: #AB0520; margin-bottom: 10px;",
        res$label
      ),
      if (res$required) {
        p("✅ This module is REQUIRED for FCHS")
      } else {
        p("⚠️ This module is OPTIONAL for FCHS")
      },
      if (state$final == "r_skip") {
        div(style = "margin-top: 10px; font-style: italic; color: #444;",
            "If your activity involved passive outreach like a booth, flyer, or media campaign, consider restarting the tree and answering Yes to the first question.")
      },
      br(),
      h4("Visual Pathway:"),
      grVizOutput("tree", height = "800px")
    )
  })
  
  # Render the visual pathway tree
  output$tree <- renderGrViz({
    selected_nodes <- unlist(lapply(state$steps, function(x) x$q))
    selected_nodes <- c(selected_nodes, state$final)
    
    highlight <- function(id) {
      if (id %in% selected_nodes) "#AB0520" else "#FFFFFF"
    }
    font_color <- function(id) {
      if (id %in% selected_nodes) "white" else "black"
    }
    
    grViz(glue::glue('
    digraph {{
      node [fontname = Calibri, shape = box, style = filled, color = "#0C234B", penwidth=2];

      q1 [label="Activity intended to reach\\nan external audience?", fillcolor="{highlight("q1")}", fontcolor="{font_color("q1")}"];
      q2 [label="One-on-one education?", fillcolor="{highlight("q2")}", fontcolor="{font_color("q2")}"];
      q2b [label="Track this one-on-one\\ninteraction in more detail?", fillcolor="{highlight("q2b")}", fontcolor="{font_color("q2b")}"];
      q3 [label="Group education ≥ 20 min?", fillcolor="{highlight("q3")}", fontcolor="{font_color("q3")}"];
      q4 [label="Primarily sharing info\\nor materials (no collaboration)?", fillcolor="{highlight("q4")}", fontcolor="{font_color("q4")}"];
      q4b [label="Part of coordinated\\nSocial Marketing campaign?", fillcolor="{highlight("q4b")}", fontcolor="{font_color("q4b")}"];
      q5 [label="Single organization\\nwith ongoing collaboration?", fillcolor="{highlight("q5")}", fontcolor="{font_color("q5")}"];
      q6 [label="Collaboration with\\nmultiple organizations?", fillcolor="{highlight("q6")}", fontcolor="{font_color("q6")}"];
      q7 [label="Site-level policy, systems,\\nor environmental change?", fillcolor="{highlight("q7")}", fontcolor="{font_color("q7")}"];

      r_direct [label="Direct Contacts", fillcolor="{highlight("r_direct")}", fontcolor="{font_color("r_direct")}"];
      r_program [label="Program Activities", fillcolor="{highlight("r_program")}", fontcolor="{font_color("r_program")}"];
      r_indirect [label="Indirect Activities", fillcolor="{highlight("r_indirect")}", fontcolor="{font_color("r_indirect")}"];
      r_partnership [label="Partnerships", fillcolor="{highlight("r_partnership")}", fontcolor="{font_color("r_partnership")}"];
      r_coalition [label="Coalitions", fillcolor="{highlight("r_coalition")}", fontcolor="{font_color("r_coalition")}"];
      r_crm [label="CRM (Optional)", fillcolor="{highlight("r_crm")}", fontcolor="{font_color("r_crm")}"];
      r_pse [label="PSE Site Activities", fillcolor="{highlight("r_pse")}", fontcolor="{font_color("r_pse")}"];
      r_social [label="Social Marketing", fillcolor="{highlight("r_social")}", fontcolor="{font_color("r_social")}"];
      r_skip [label="Outside Engage\\n(Consider Reflect)", fillcolor="{highlight("r_skip")}", fontcolor="{font_color("r_skip")}"];

      q1 -> q2 [label="Yes"];
      q1 -> r_skip [label="No"];
      q2 -> q2b [label="Yes"];
      q2b -> r_crm [label="Yes"];
      q2b -> r_direct [label="No"];
      q2 -> q3 [label="No"];
      q3 -> r_program [label="Yes"];
      q3 -> q4 [label="No"];
      q4 -> q4b [label="No"];
      q4b -> r_social [label="Yes"];
      q4b -> r_indirect [label="No"];
      q4 -> q5 [label="No"];
      q5 -> r_partnership [label="Yes"];
      q5 -> q6 [label="No"];
      q6 -> r_coalition [label="Yes"];
      q6 -> q7 [label="No"];
      q7 -> r_pse [label="Yes"];
      q7 -> r_skip [label="No"];
    }}
  '))
  })
  
  
  # Navigate to the Decision Tree tab when the button is clicked
  observeEvent(input$jump_to_tree, {
    updateTabItems(session, "tabs", selected = "tree")
  })
  
  
}
