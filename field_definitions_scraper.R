library(rvest)

##################
# Html structure
##################
#
# <h3 id="conformingloanlimitconformingloanlimit">
#   <a href="#conforming_loan_limit">conforming_loan_limit</a>
# </h3>
# <ul>
#   <li>
#     <strong>Description:</strong> Indicates whether the reported loan amount exceeds the GSE (government sponsored enterprise) conforming loan limit
#   </li>
#   <li>
#     <strong>Values:</strong>
#     <ul>
#       <li>C (Conforming)</li>
#       <li>NC (Nonconforming)</li>
#       <li>U (Undetermined)</li>
#       <li>NA (Not Applicable)</li>
#     </ul>
#   </li>
# </ul>

# fields_of_interest <- [
#   'conforming_loan_limit',
#   'action_taken',
#   'purchaser_type',
#   'preapproval',
#   'loan_type',
#   'loan_purpose',
#   'lien_status',
#   'reverse_mortgage',
#   'open_end_line_of_credit',
#   'business_or_commercial_purpose',
#   'hoepa_status',
#   'negative_amortization',
#   'interest_only_payment',
#   etc...
# ]

# just copied the file manually cause I don't want to deal with the javascript on the HMDA site right now...
hmda <- read_html('./hmda_fields_2020.html')

field_names <- hmda %>% html_elements('h3')

