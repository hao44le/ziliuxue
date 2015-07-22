//
//  College.swift
//  ziliuxue
//
//  Created by Gelei Chen on 7/14/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import Foundation

class College: NSObject {
    var id : String
    var name : String
    var city : String
    var state : String
    var country : String
    var zipcode : String
    var website : String
    var logo : String
    var photos : [String]
    
    
    
    init(id:String,name:String,city:String,state:String,country:String,zipcode:String,website:String,logo:String,photos:[String]){
        
        self.id = id
        self.name = name
        self.city = city
        self.state = state
        self.country = country
        self.zipcode = zipcode
        self.website = website
        self.logo = logo
        self.photos = photos
    }
}

class CollegeOverview : NSObject {
    var rankins : NSDictionary
    var school_type : String
    var year_founded : String
    var religious_affiliation : String
    var academic_calendar : String
    var setting : String
    var endowment : String
    var selectivity: String
    var acceptance_rate : String
    var application_deadline : String
    var SAT_ACT_scores_must_be_received_by : String
    var student_faculty_ration : String
    var four_year_graduation_rate : String
    var five_most_popular_majors : NSDictionary
    var tuition_and_fees : String
    var room_and_board : String
    init(rankins:NSDictionary,school_type:String,year_founded:String,religious_affiliation:String,academic_calendar:String,setting:String,endowment:String,selectivity:String,acceptance_rate:String,application_deadline:String,SAT_ACT_scores_must_be_received_by:String,student_faculty_ration:String,four_year_graduation_rate:String,five_most_popular_majors:NSDictionary,tuition_and_fees:String,room_and_board:String){
            self.rankins = rankins
        self.school_type = school_type
        self.year_founded = year_founded
        self.religious_affiliation = religious_affiliation
        self.academic_calendar = academic_calendar
        self.setting = setting
        self.endowment = endowment
        self.selectivity = selectivity
        self.acceptance_rate = acceptance_rate
        self.application_deadline = application_deadline
        self.SAT_ACT_scores_must_be_received_by = SAT_ACT_scores_must_be_received_by
        self.student_faculty_ration = student_faculty_ration
        self.four_year_graduation_rate = four_year_graduation_rate
        self.five_most_popular_majors = five_most_popular_majors
        self.tuition_and_fees = tuition_and_fees
        self.room_and_board = room_and_board
    }
}

class CollegeRanking : NSObject {
    var rankings : NSDictionary
    var score : String
    var high_school_counselor_score : String
    var average_freshman_retention_rate : String
    var classes_with_fewer_than_20_students : String
    var classes_with_50_or_more_students : String
    var student_falculty_ratio : String
    var acceptance_rate : String
    var six_year_graduation_rate : String
    var predicated_graduation_rate : String
    var overperformance_over_underperformance : String
    var graduation_and_retention_rank : String
    var peer_assessment_score : String
    var faculty_resources_rank : String
    var percent_of_faculty_who_are_fulltime : String
    var student_selectivity_rank : String
    var SAT_ACT_25th_75th_percentile : String
    var freshmen_in_top10percent_of_high_school_class : String
    var freshmen_in_top25percent_of_high_school_class : String
    var financial_resource_rank : String
    var alumni_giving_rank : String
    var average_alumni_giving_rate : String
    
    init(rankings:NSDictionary,score:String,high_school_counselor_score:String,average_freshman_retention_rate : String,classes_with_fewer_than_20_students : String,classes_with_50_or_more_students : String,student_falculty_ratio : String,acceptance_rate : String,six_year_graduation_rate : String,predicated_graduation_rate : String,overperformance_over_underperformance : String,graduation_and_retention_rank : String,peer_assessment_score : String,faculty_resources_rank : String,percent_of_faculty_who_are_fulltime : String,student_selectivity_rank : String,SAT_ACT_25th_75th_percentile : String,freshmen_in_top10percent_of_high_school_class : String,freshmen_in_top25percent_of_high_school_class : String,financial_resource_rank : String,alumni_giving_rank : String,average_alumni_giving_rate : String){
            self.rankings = rankings
        self.score = score
        self.high_school_counselor_score  = high_school_counselor_score
        self.average_freshman_retention_rate = average_freshman_retention_rate
        self.classes_with_fewer_than_20_students = classes_with_fewer_than_20_students
        self.classes_with_50_or_more_students = classes_with_50_or_more_students
        self.student_falculty_ratio = student_falculty_ratio
        self.acceptance_rate = acceptance_rate
        self.six_year_graduation_rate = six_year_graduation_rate
        self.predicated_graduation_rate = predicated_graduation_rate
        self.overperformance_over_underperformance = overperformance_over_underperformance
        self.graduation_and_retention_rank = graduation_and_retention_rank
        self.peer_assessment_score = peer_assessment_score
        self.faculty_resources_rank = faculty_resources_rank
        self.percent_of_faculty_who_are_fulltime = percent_of_faculty_who_are_fulltime
        self.student_selectivity_rank = student_selectivity_rank
        self.SAT_ACT_25th_75th_percentile = SAT_ACT_25th_75th_percentile
        self.freshmen_in_top10percent_of_high_school_class = freshmen_in_top10percent_of_high_school_class
        self.freshmen_in_top25percent_of_high_school_class = freshmen_in_top25percent_of_high_school_class
        self.financial_resource_rank = financial_resource_rank
        self.alumni_giving_rank = alumni_giving_rank
        self.average_alumni_giving_rate = average_alumni_giving_rate
    }
    
    
}


class CollegeApplying : NSObject {
    //applications
        //regular_decision
    var application_deadline : String
            var priority_application_deadline : String
            var notification_date : String
            var deadline_for_accepting_admission_offers : String
            var students_accepted_for_terms_other_than_the_fall : String
    
        //early_decision
            var early_decision_plan_offered : String
            var early_decision_deadline : String
            var early_decision_sent_by : String
    
        //early_action
            var early_action_plan_offered : String
            var students_restricted_from_applying_to_other_early_action_plans : String
            var early_action_deadline : String
            var early_action_decision_sent_by : String
    
        //application_fee
            var application_fee : String
            var application_fee_refundable : String
            var application_fee_waived_for_stdents_with_financial_need : String
            var application_fee_for_students_who_apply_online : String
            var deferred_admission_allowed : String
            var maximum_length_of_determent : String
    
    
        //application_formats
            var application_url : String
            var common_application_accepted : String
    
        //tuition_room_deposits
            var tuition_deposit : String
            var tuition_deposit_refundable : String
            var room_deposit : String
            var room_deposit_refundable : String
    
        //contact_information
            var admission_phone : String
            var admission_email : String
            var admission_address : String
    //requirements
        //admission_requirements
            var admission_interview : String
            var campus_visit : String
            var offcampus_interviews : String
            var open_admission_policy : String
    var college_use_SAT_or_ACT_in_admission_decisions : String
    var required_standardized_tests : String
    var ACT_with_writing_test : String
    var SAT_ACT_scores_must_be_received_by : String
    var SAT_subject_test_scores_must_be_received_by : String
        //academic_factors_considered
    var rigor_of_secondary_school_record : String
    var class_rank : String
    var GPA : String
    var standardized_test_scores : String
    var application_essay : String
    var recommendations : String
    var SAT_subject_tests : String
    
        //nonacademic_factors_considered
    var interview : String
    var extracurricular_activities : String
    var talent_ability : String
    var character_personal_qualities : String
    var first_generation_college_student : String
    var alumni_relations : String
    var geographical_residence : String
    var state_residency : String
    var religious_affiliation : String
    var race_ethnicity : String
    var volunteer_work : String
    var work_experience : String
    var applicants_interest_level : String
    //entering_class_stats
        //selectivity
    var selectivity : String
    var acceptance_rate : String
    var early_decision_acceptance_rate : String
    var early_action_acceptance_rate : String
    var acceptance_rate_wo_early_decision : String
    
        //applications_acceptance_enrollments
    var applicants : String
    var female_applicants : String
    var male_applicants : String
    var applicants_accepted : String
    var female_applicants_accepted : String
    var male_applicants_accepted : String
    var freshman_enrollment : String
        //wait_list
    var school_has_a_wait_list : String
    var applicants_placed_on_wait_list : String
    var students_accepting_place_on_wait_list : String
    var students_accepted_from_wait_list : String
    
    init(application_deadline : String,priority_application_deadline : String,notification_date : String,deadline_for_accepting_admission_offers : String,students_accepted_for_terms_other_than_the_fall : String,early_decision_plan_offered : String,early_decision_deadline : String,early_decision_sent_by : String,early_action_plan_offered : String,students_restricted_from_applying_to_other_early_action_plans : String,early_action_deadline : String,early_action_decision_sent_by : String,application_fee : String,application_fee_refundable : String,application_fee_waived_for_stdents_with_financial_need : String,application_fee_for_students_who_apply_online : String,deferred_admission_allowed : String,maximum_length_of_determent : String,application_url : String,common_application_accepted : String,tuition_deposit : String,tuition_deposit_refundable : String,room_deposit : String,room_deposit_refundable : String,admission_phone : String,admission_email : String,admission_address : String,admission_interview : String,campus_visit : String,offcampus_interviews : String,open_admission_policy : String,college_use_SAT_or_ACT_in_admission_decisions : String,required_standardized_tests : String,ACT_with_writing_test : String,SAT_ACT_scores_must_be_received_by : String,SAT_subject_test_scores_must_be_received_by : String,rigor_of_secondary_school_record : String,class_rank : String,GPA : String,standardized_test_scores : String,application_essay : String,recommendations : String,SAT_subject_tests : String,interview : String,extracurricular_activities : String,talent_ability : String,character_personal_qualities : String,first_generation_college_student : String,alumni_relations : String,geographical_residence : String,state_residency : String,religious_affiliation : String,race_ethnicity : String,volunteer_work : String,work_experience : String,applicants_interest_level : String,selectivity : String,acceptance_rate : String,early_decision_acceptance_rate : String,early_action_acceptance_rate : String,acceptance_rate_wo_early_decision : String,applicants : String,female_applicants : String,male_applicants : String,applicants_accepted : String,female_applicants_accepted : String,male_applicants_accepted : String,freshman_enrollment : String,school_has_a_wait_list : String,applicants_placed_on_wait_list : String,students_accepting_place_on_wait_list : String,students_accepted_from_wait_list : String){
        self.application_deadline = application_deadline
        self.priority_application_deadline = priority_application_deadline
        self.notification_date = notification_date
        self.deadline_for_accepting_admission_offers = deadline_for_accepting_admission_offers
        self.students_accepted_for_terms_other_than_the_fall = students_accepted_for_terms_other_than_the_fall
        self.early_decision_plan_offered = early_decision_plan_offered
        self.early_decision_deadline = early_decision_deadline
        self.early_decision_sent_by = early_decision_sent_by
        self.early_action_plan_offered = early_action_plan_offered
        self.students_restricted_from_applying_to_other_early_action_plans = students_restricted_from_applying_to_other_early_action_plans
        self.early_action_deadline = early_action_deadline
        self.early_action_decision_sent_by = early_action_decision_sent_by
        self.application_fee = application_fee
        self.application_fee_refundable = application_fee_refundable
        self.application_fee_waived_for_stdents_with_financial_need = application_fee_waived_for_stdents_with_financial_need
        self.application_fee_for_students_who_apply_online = application_fee_for_students_who_apply_online
        self.deferred_admission_allowed = deferred_admission_allowed
        self.maximum_length_of_determent = maximum_length_of_determent
        self.application_url = application_url
        self.common_application_accepted = common_application_accepted
        self.tuition_deposit = tuition_deposit
        self.tuition_deposit_refundable = tuition_deposit_refundable
        self.room_deposit = room_deposit
        self.room_deposit_refundable = room_deposit_refundable
        self.admission_phone = admission_phone
        self.admission_email = admission_email
        self.admission_address = admission_address
        self.admission_interview = admission_interview
        self.campus_visit = campus_visit
        self.offcampus_interviews = offcampus_interviews
        self.open_admission_policy =  open_admission_policy
        self.college_use_SAT_or_ACT_in_admission_decisions = college_use_SAT_or_ACT_in_admission_decisions
        self.required_standardized_tests  =  required_standardized_tests
        self.ACT_with_writing_test  = ACT_with_writing_test
        self.SAT_ACT_scores_must_be_received_by  = SAT_ACT_scores_must_be_received_by
        self.SAT_subject_test_scores_must_be_received_by  = SAT_subject_test_scores_must_be_received_by
        self.rigor_of_secondary_school_record  = rigor_of_secondary_school_record
        self.class_rank  = class_rank
        self.GPA  = GPA
        self.standardized_test_scores  = standardized_test_scores
        self.application_essay  = application_essay
        self.recommendations  = recommendations
        self.SAT_subject_tests  = SAT_subject_tests
        self.interview  = interview
        self.extracurricular_activities  = extracurricular_activities
        self.talent_ability  = talent_ability
        self.character_personal_qualities  = character_personal_qualities
        self.first_generation_college_student  = first_generation_college_student
        self.alumni_relations  = alumni_relations
        self.geographical_residence  = geographical_residence
        self.state_residency  = state_residency
        self.religious_affiliation  = religious_affiliation
        self.race_ethnicity   = race_ethnicity
        self.volunteer_work  = volunteer_work
        self.work_experience  = work_experience
        self.applicants_interest_level  = applicants_interest_level
        self.selectivity  = selectivity
        self.acceptance_rate  = acceptance_rate
        self.early_decision_acceptance_rate  = early_decision_acceptance_rate
        self.early_action_acceptance_rate  = early_action_acceptance_rate
        self.acceptance_rate_wo_early_decision  = acceptance_rate_wo_early_decision
        self.applicants  = applicants
        self.female_applicants  = female_applicants
        self.male_applicants  = male_applicants
        self.applicants_accepted  = applicants_accepted
        self.female_applicants_accepted   = female_applicants_accepted
        self.male_applicants_accepted   = male_applicants_accepted
        self.freshman_enrollment   = freshman_enrollment
        self.school_has_a_wait_list  = school_has_a_wait_list
        self.applicants_placed_on_wait_list   = applicants_placed_on_wait_list
        self.students_accepting_place_on_wait_list  = students_accepting_place_on_wait_list
        self.students_accepted_from_wait_list = students_accepted_from_wait_list
    }
}
class CollegeAcademic: NSObject {
    //faculty_and_classes
    var student_faculty_ratio : String
    var total_faculty : String
    var minority : String
    var international : String
    var full_time_faculty_with_phd_or_terminal_degree : String
    var classes_taught_by_graduate_assistants : String
    
    
    
    
    
    
    
    //majors
        //five_most_popular_majors
    var five_most_popular_majors : NSDictionary
        //all_majors
    var all_majors : NSArray
    //academic_programs
    var degrees_offered : String
    var qualified_undergraduate_may_take_graduate_classes : String
    var preprofessional_programs : String
    var teacher_certification_offered_in : String
    var subject_areas_offering_education_certification : String
    var student_exchange_programs_offered_with : String
    //graduation_and_retention
    var average_freshman_retention_rate : String
    var six_year_graduation_rate : String
    var bachelors_degrees_awarded : String
    var masters_degrees_awarded : String
    var doctoral_degrees_research : String
    var pursued_further_study_immediately_after_graduation : String
    var pursued_further_study_in_law : String
    var pursued_further_study_in_medicine : String
    
    
    init(student_faculty_ratio : String,total_faculty : String,minority : String,international : String,full_time_faculty_with_phd_or_terminal_degree : String,classes_taught_by_graduate_assistants : String,five_most_popular_majors : NSDictionary,all_majors : NSArray,degrees_offered : String,qualified_undergraduate_may_take_graduate_classes : String,preprofessional_programs : String,teacher_certification_offered_in : String,subject_areas_offering_education_certification : String,student_exchange_programs_offered_with : String,average_freshman_retention_rate : String,six_year_graduation_rate : String,bachelors_degrees_awarded : String,masters_degrees_awarded : String,doctoral_degrees_research : String,pursued_further_study_immediately_after_graduation : String,pursued_further_study_in_law : String,pursued_further_study_in_medicine : String){
        self.student_faculty_ratio = student_faculty_ratio
        self.total_faculty = total_faculty
        self.minority =  minority
        self.international = international
        self.full_time_faculty_with_phd_or_terminal_degree = full_time_faculty_with_phd_or_terminal_degree
        self.classes_taught_by_graduate_assistants = classes_taught_by_graduate_assistants
        self.five_most_popular_majors = five_most_popular_majors
        self.all_majors = all_majors
        self.degrees_offered = degrees_offered
        self.qualified_undergraduate_may_take_graduate_classes = qualified_undergraduate_may_take_graduate_classes
        self.preprofessional_programs = preprofessional_programs
        self.teacher_certification_offered_in = teacher_certification_offered_in
        self.subject_areas_offering_education_certification = subject_areas_offering_education_certification
        self.student_exchange_programs_offered_with = student_exchange_programs_offered_with
        self.average_freshman_retention_rate = average_freshman_retention_rate
        self.six_year_graduation_rate = six_year_graduation_rate
        self.bachelors_degrees_awarded = bachelors_degrees_awarded
        self.masters_degrees_awarded = masters_degrees_awarded
        self.doctoral_degrees_research = doctoral_degrees_research
        self.pursued_further_study_immediately_after_graduation = pursued_further_study_immediately_after_graduation
        self.pursued_further_study_in_law = pursued_further_study_in_law
        self.pursued_further_study_in_medicine = pursued_further_study_in_medicine
    }
}


class CollegeFinancial : NSObject {
    var tuition_and_fees : String
    var room_and_board : String
    var estimated_cost_of_books_and_supplies : String
    var estimated_personal_expenses : String
    var average_need_based_scholarship : String
    var students_who_received_need_based_scholarship : String
    
    init(tuition_and_fees : String,room_and_board : String,estimated_cost_of_books_and_supplies : String,estimated_personal_expenses : String,average_need_based_scholarship : String,students_who_received_need_based_scholarship : String){
        self.tuition_and_fees = tuition_and_fees
        self.room_and_board = room_and_board
        self.estimated_cost_of_books_and_supplies = estimated_cost_of_books_and_supplies
        self.estimated_personal_expenses = estimated_personal_expenses
        self.average_need_based_scholarship = average_need_based_scholarship
        self.students_who_received_need_based_scholarship = students_who_received_need_based_scholarship
    }
}



class CollegeDetail: NSObject{
    var collge: College
    var collegeOverview : CollegeOverview
    var collegeRanking : CollegeRanking
    var collegeApplying : CollegeApplying
    var collegeAcademic : CollegeAcademic
    var collegeFinancial : CollegeFinancial
    init(college:College,collegeOverview : CollegeOverview,collegeRanking : CollegeRanking,collegeApplying : CollegeApplying,collegeAcademic : CollegeAcademic,collegeFinancial : CollegeFinancial){
        self.collge = college
        self.collegeOverview = collegeOverview
        self.collegeRanking = collegeRanking
        self.collegeApplying = collegeApplying
        self.collegeAcademic = collegeAcademic
        self.collegeFinancial = collegeFinancial
    }
}