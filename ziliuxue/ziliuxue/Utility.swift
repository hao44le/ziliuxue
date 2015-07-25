//
//  Utility.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/24/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
}


struct LocalStore {
    
    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static func setIntroAsVisited() {
        userDefaults.setObject(true, forKey: "introKey")
    }
    
    static func isIntroVisited() -> Bool {
        return userDefaults.boolForKey("introKey")
    }
    
    static func isLogined()->Bool{
        return userDefaults.boolForKey("loginKey")
    }
    
    static func setLogined(){
        userDefaults.setObject(true, forKey: "loginKey")
    }
    
    static func setLogout(){
        userDefaults.setObject("", forKey: "token")
        userDefaults.setObject("", forKey: "refresh_token")
        userDefaults.setObject(nil, forKey: "weChat_userImageUrl")
        userDefaults.setObject(nil, forKey: "weChat_userNickname")
        userDefaults.setObject(nil, forKey: "weChat_token")
        userDefaults.setObject(nil, forKey: "nickName")
        userDefaults.setObject(false, forKey: "loginKey")
        userDefaults.setObject(nil, forKey: "loginWay")
    }
    
    
}
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct ServerMethods {
    
    
    
    static func createUserProfile(country:String,degree:String,major:String,gpa:Float,toefl:Float,sat:Float,my_schools:[String]){
        
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        if let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as? String {
            manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
            let target = NSDictionary(objectsAndKeys: country,"country",degree,"degree",major,"major")
            let scores = NSDictionary(objectsAndKeys: gpa,"gpa",toefl,"toefl",sat,"sat")
            let profile = NSDictionary(objectsAndKeys: scores,"scores",target,"target",my_schools,"my_schools")
            let parameter = NSDictionary(objectsAndKeys: profile,"profile")
            print(parameter)
            
            manager.POST(ServerConstant.user_profile, parameters: parameter
                , success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                    NSNotificationCenter.defaultCenter().postNotificationName("createUserProfileSuccessed", object: nil)
                    print("createUserProfile success\n")
                    let dic = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                    print(dic)
                    
                }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    NSNotificationCenter.defaultCenter().postNotificationName("createUserProfileFailed", object: nil)
                    print("createUserProfile failure\n")
                    print(error)
            }

        }
        
        
    }
    
    static func updateUserProfile(country:String,degree:String,major:String,gpa:Float,toefl:Float,sat:Float,my_schools:[String]){
        
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        let target = NSDictionary(objectsAndKeys: country,"country",degree,"degree",major,"major")
        let scores = NSDictionary(objectsAndKeys: gpa,"gpa",toefl,"toefl",sat,"sat")
        let profile = NSDictionary(objectsAndKeys: scores,"scores",target,"target",my_schools,"my_schools")
        let parameter = NSDictionary(objectsAndKeys: profile,"profile")
        print(parameter)
        
        manager.PUT(ServerConstant.user_profile, parameters: parameter
            , success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("updateUserProfileSuccessed", object: nil)
                print("updateUserProfile success\n")
                let dic = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                print(dic)
                
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("updateUserProfileFailed", object: nil)
                print("updateUserProfile failure\n")
                print(error)
        }
        
    }
    
    static func getUserProfile(){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        
        manager.GET(ServerConstant.user_profile, parameters: nil
            , success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getUserProfileSuccessed", object: nil)
                print("getUserProfile success\n")
                
                let dic =  NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                
                print(dic)
                
                //print(response)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getUserProfileFailed", object: nil)
                print("getUserProfile failure\n")
                print(error)
        }
    }
    
    
    static func getCollegeDetail(collegeID:String){
        let manager = AFHTTPRequestOperationManager()
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        manager.GET(getCorrectBreakPointForCollegeDetail(collegeID), parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            print("getCollegeDetail success\n")
            if let message = response.objectForKey("message") as? String {
                //not found
                print(message)
            } else {
                //found result
                print(response)
                
                
                
                
                
                
                let id = response.objectForKey("_id") as! String
                let name = response.objectForKey("name") as! String
                
                let general = response.objectForKey("general") as! NSDictionary
                let overview = response.objectForKey("overview") as! NSDictionary
                let rankings = response.objectForKey("rankings") as! NSDictionary
                let applying = response.objectForKey("applying") as! NSDictionary
                let academic = response.objectForKey("academic") as! NSDictionary
                let financial = response.objectForKey("financial") as! NSDictionary
                
                
                
                //一次性保存20个college做cache
                // full path for local file data.plist
                let documentDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
                let path = documentDir.stringByAppendingPathComponent("\(name).plist")
                let data : NSDictionary = response as! NSDictionary
                data.writeToFile(path, atomically: true)
                
                
                
                let website = general.objectForKey("website") as! String
                let logo = general.objectForKey("logo") as! String
                let address = general.objectForKey("address") as! NSDictionary
                let photos = general.objectForKey("photos") as! [String]
                
                let city = address.objectForKey("city") as! String
                let country = address.objectForKey("country") as! String
                let state = address.objectForKey("state") as! String
                let zipcode = address.objectForKey("zipcode") as! String
                
                let college = College(id: id, name: name, city: city, state: state, country: country, zipcode: zipcode, website: website, logo: logo, photos: photos)
                
                //-------------------------------------------------------------------------------------------------------------
                //overview
                let _rankings = overview.objectForKey("rankings") as! NSDictionary
                let general_information = overview.objectForKey("general_information") as! NSDictionary
                let _applying = overview.objectForKey("applying") as! NSDictionary
                let _financial = overview.objectForKey("financial") as! NSDictionary
                let _academic = overview.objectForKey("academic") as! NSDictionary
                
                
                
                //general_information
                let school_type = general_information.objectForKey("school_type") as! String
                let year_founded = general_information.objectForKey("year_founded") as! String
                let religious_affiliation = general_information.objectForKey("religious_affiliation") as! String
                let academic_calendar = general_information.objectForKey("academic_calendar") as! String
                let setting = general_information.objectForKey("setting") as! String
                let endowment = general_information.objectForKey("endowment") as! String
                // applying
                let selectivity = _applying.objectForKey("selectivity") as! String
                let acceptance_rate = _applying.objectForKey("acceptance_rate") as! String
                let application_deadline = _applying.objectForKey("application_deadline") as! String
                let SAT_ACT_scores_must_be_received_by = _applying.objectForKey("SAT_ACT_scores_must_be_received_by") as! String
                // academic
                let student_faculty_ration = _academic.objectForKey("student_faculty_ration") as! String
                let four_year_graduation_rate = _academic.objectForKey("four_year_graduation_rate") as! String
                let five_most_popular_majors = _academic.objectForKey("five_most_popular_majors") as! NSDictionary
                
                // financial
                let tuition_and_fees = _financial.objectForKey("tuition_and_fees") as! String
                let room_and_board = _financial.objectForKey("room_and_board") as! String
                
                
                
                let collegeOverview = CollegeOverview(rankins: _rankings, school_type: school_type, year_founded: year_founded, religious_affiliation: religious_affiliation, academic_calendar: academic_calendar, setting: setting, endowment: endowment, selectivity: selectivity, acceptance_rate: acceptance_rate, application_deadline: application_deadline, SAT_ACT_scores_must_be_received_by: SAT_ACT_scores_must_be_received_by, student_faculty_ration: student_faculty_ration, four_year_graduation_rate: four_year_graduation_rate, five_most_popular_majors: five_most_popular_majors, tuition_and_fees: tuition_and_fees, room_and_board: room_and_board)
                
                //-------------------------------------------------------------------------------------------------------------
                //rankings
                
                let rankings_rankings = rankings.objectForKey("rankings") as! NSDictionary
                let key_indicators = rankings.objectForKey("key_indicators") as! NSDictionary
                
                let score = key_indicators.objectForKey("score") as! String
                let high_school_counselor_score = key_indicators.objectForKey("high_school_counselor_score") as! String
                let average_freshman_retention_rate = key_indicators.objectForKey("average_freshman_retention_rate") as! String
                let classes_with_fewer_than_20_students = key_indicators.objectForKey("classes_with_fewer_than_20_students") as! String
                let classes_with_50_or_more_students = key_indicators.objectForKey("classes_with_50_or_more_students") as! String
                let student_falculty_ratio = key_indicators.objectForKey("student_falculty_ratio") as! String
                let _acceptance_rate = key_indicators.objectForKey("acceptance_rate") as! String
                let six_year_graduation_rate = key_indicators.objectForKey("six_year_graduation_rate") as! String
                let predicated_graduation_rate = key_indicators.objectForKey("predicated_graduation_rate") as! String
                let overperformance_over_underperformance = key_indicators.objectForKey("overperformance_over_underperformance") as! String
                let graduation_and_retention_rank = key_indicators.objectForKey("graduation_and_retention_rank") as! String
                
                let peer_assessment_score = key_indicators.objectForKey("peer_assessment_score") as! String
                let faculty_resources_rank = key_indicators.objectForKey("faculty_resources_rank") as! String
                let percent_of_faculty_who_are_fulltime = key_indicators.objectForKey("percent_of_faculty_who_are_fulltime") as! String
                
                let student_selectivity_rank = key_indicators.objectForKey("student_selectivity_rank") as! String
                let SAT_ACT_25th_75th_percentile = key_indicators.objectForKey("SAT_ACT_25th_75th_percentile") as! String
                let freshmen_in_top10percent_of_high_school_class = key_indicators.objectForKey("freshmen_in_top10percent_of_high_school_class") as! String
                let freshmen_in_top25percent_of_high_school_class = key_indicators.objectForKey("freshmen_in_top25percent_of_high_school_class") as! String
                
                let financial_resource_rank = key_indicators.objectForKey("financial_resource_rank") as! String
                let alumni_giving_rank = key_indicators.objectForKey("alumni_giving_rank") as! String
                let average_alumni_giving_rate = key_indicators.objectForKey("average_alumni_giving_rate") as! String
                
                
                let collegeRanking = CollegeRanking(rankings: rankings_rankings, score: score, high_school_counselor_score: high_school_counselor_score, average_freshman_retention_rate: average_freshman_retention_rate, classes_with_fewer_than_20_students: classes_with_fewer_than_20_students, classes_with_50_or_more_students: classes_with_50_or_more_students, student_falculty_ratio: student_falculty_ratio, acceptance_rate: _acceptance_rate, six_year_graduation_rate: six_year_graduation_rate, predicated_graduation_rate: predicated_graduation_rate, overperformance_over_underperformance: overperformance_over_underperformance, graduation_and_retention_rank: graduation_and_retention_rank, peer_assessment_score: peer_assessment_score, faculty_resources_rank: faculty_resources_rank, percent_of_faculty_who_are_fulltime: percent_of_faculty_who_are_fulltime, student_selectivity_rank: student_selectivity_rank, SAT_ACT_25th_75th_percentile: SAT_ACT_25th_75th_percentile, freshmen_in_top10percent_of_high_school_class: freshmen_in_top10percent_of_high_school_class, freshmen_in_top25percent_of_high_school_class: freshmen_in_top25percent_of_high_school_class, financial_resource_rank: financial_resource_rank, alumni_giving_rank: alumni_giving_rank, average_alumni_giving_rate: average_alumni_giving_rate)
                
                //-------------------------------------------------------------------------------------------------------------
                //applying
                
                
                //applications
                let applications = applying.objectForKey("applications") as! NSDictionary
                
                //regular_decision
                let regular_decision = applications.objectForKey("regular_decision") as! NSDictionary
                
                let _application_deadline = regular_decision.objectForKey("application_deadline") as! String
                let priority_application_deadline = regular_decision.objectForKey("priority_application_deadline") as! String
                let notification_date = regular_decision.objectForKey("notification_date") as! String
                let deadline_for_accepting_admission_offers = regular_decision.objectForKey("deadline_for_accepting_admission_offers") as! String
                let students_accepted_for_terms_other_than_the_fall = regular_decision.objectForKey("students_accepted_for_terms_other_than_the_fall") as! String
                
                
                
                //early_decision
                let early_decision = applications.objectForKey("early_decision") as! NSDictionary
                
                let early_decision_plan_offered = early_decision.objectForKey("early_decision_plan_offered") as! String
                let early_decision_deadline = early_decision.objectForKey("early_decision_deadline") as! String
                let early_decision_sent_by = early_decision.objectForKey("early_decision_sent_by") as! String
                
                
                
                
                
                //early_action
                let early_action = applications.objectForKey("early_action") as! NSDictionary
                let early_action_plan_offered = early_action.objectForKey("early_action_plan_offered") as! String
                let students_restricted_from_applying_to_other_early_action_plans = early_action.objectForKey("students_restricted_from_applying_to_other_early_action_plans") as! String
                let early_action_deadline = early_action.objectForKey("early_action_deadline") as! String
                
                let early_action_decision_sent_by = early_action.objectForKey("early_action_decision_sent_by") as! String
                
                
                
                
                
                
                
                
                
                //application_fee
                let application_fee = applications.objectForKey("application_fee") as! NSDictionary
                
                let _application_fee = application_fee.objectForKey("application_fee") as! String
                let application_fee_refundable = application_fee.objectForKey("application_fee_refundable") as! String
                let application_fee_waived_for_stdents_with_financial_need = application_fee.objectForKey("application_fee_waived_for_stdents_with_financial_need") as! String
                let application_fee_for_students_who_apply_online = application_fee.objectForKey("application_fee_for_students_who_apply_online") as! String
                let deferred_admission_allowed = application_fee.objectForKey("deferred_admission_allowed") as! String
                let maximum_length_of_determent = application_fee.objectForKey("maximum_length_of_determent") as! String
                
                
                
                
                
                
                
                //application_formats
                let application_formats = applications.objectForKey("application_formats") as! NSDictionary
                
                
                let application_url = application_formats.objectForKey("application_url") as! String
                let common_application_accepted = application_formats.objectForKey("common_application_accepted") as! String
                
                
                
                
                
                //tuition_room_deposits
                let tuition_room_deposits = applications.objectForKey("tuition_room_deposits") as! NSDictionary
                
                let tuition_deposit = tuition_room_deposits.objectForKey("tuition_deposit") as! String
                let tuition_deposit_refundable = tuition_room_deposits.objectForKey("tuition_deposit_refundable") as! String
                let room_deposit = tuition_room_deposits.objectForKey("room_deposit") as! String
                let room_deposit_refundable = tuition_room_deposits.objectForKey("room_deposit_refundable") as! String
                
                
                
                
                //contact_information
                let contact_information = applications.objectForKey("contact_information") as! NSDictionary
                let admission_phone = contact_information.objectForKey("admission_phone") as! String
                let admission_email = contact_information.objectForKey("admission_email") as! String
                let admission_address = contact_information.objectForKey("admission_address") as! String
                
                
                
                
                
                //requirements
                let requirements = applying.objectForKey("requirements") as! NSDictionary
                
                
                
                
                //admission_requirements
                let admission_requirements = requirements.objectForKey("admission_requirements") as! NSDictionary
                
                let admission_interview = admission_requirements.objectForKey("admission_interview") as! String
                let campus_visit = admission_requirements.objectForKey("campus_visit") as! String
                let offcampus_interviews = admission_requirements.objectForKey("offcampus_interviews") as! String
                let open_admission_policy = admission_requirements.objectForKey("open_admission_policy") as! String
                let college_use_SAT_or_ACT_in_admission_decisions = admission_requirements.objectForKey("college_use_SAT_or_ACT_in_admission_decisions") as! String
                let required_standardized_tests = admission_requirements.objectForKey("required_standardized_tests") as! String
                let ACT_with_writing_test = admission_requirements.objectForKey("ACT_with_writing_test") as! String
                let _SAT_ACT_scores_must_be_received_by = admission_requirements.objectForKey("SAT_ACT_scores_must_be_received_by") as! String
                let SAT_subject_test_scores_must_be_received_by = admission_requirements.objectForKey("SAT_subject_test_scores_must_be_received_by") as! String
                
                
                
                
                
                
                
                //academic_factors_considered
                let academic_factors_considered = requirements.objectForKey("academic_factors_considered") as! NSDictionary
                
                let rigor_of_secondary_school_record = academic_factors_considered.objectForKey("rigor_of_secondary_school_record") as! String
                let class_rank = academic_factors_considered.objectForKey("class_rank") as! String
                let GPA = academic_factors_considered.objectForKey("GPA") as! String
                let standardized_test_scores = academic_factors_considered.objectForKey("standardized_test_scores") as! String
                let application_essay = academic_factors_considered.objectForKey("application_essay") as! String
                let recommendations = academic_factors_considered.objectForKey("recommendations") as! String
                let SAT_subject_tests = academic_factors_considered.objectForKey("SAT_subject_tests") as! String
                
                
                
                
                
                //nonacademic_factors_considered
                let nonacademic_factors_considered = requirements.objectForKey("nonacademic_factors_considered") as! NSDictionary
                
                let interview = nonacademic_factors_considered.objectForKey("interview") as! String
                let extracurricular_activities = nonacademic_factors_considered.objectForKey("extracurricular_activities") as! String
                let talent_ability = nonacademic_factors_considered.objectForKey("talent_ability") as! String
                let character_personal_qualities = nonacademic_factors_considered.objectForKey("character_personal_qualities") as! String
                let first_generation_college_student = nonacademic_factors_considered.objectForKey("first_generation_college_student") as! String
                let alumni_relations = nonacademic_factors_considered.objectForKey("alumni_relations") as! String
                let geographical_residence = nonacademic_factors_considered.objectForKey("geographical_residence") as! String
                let state_residency = nonacademic_factors_considered.objectForKey("state_residency") as! String
                let _religious_affiliation = nonacademic_factors_considered.objectForKey("religious_affiliation") as! String
                let race_ethnicity = nonacademic_factors_considered.objectForKey("race_ethnicity") as! String
                let volunteer_work = nonacademic_factors_considered.objectForKey("volunteer_work") as! String
                let work_experience = nonacademic_factors_considered.objectForKey("work_experience") as! String
                let applicants_interest_level = nonacademic_factors_considered.objectForKey("applicants_interest_level") as! String
                
                
                
                //entering_class_stats
                let entering_class_stats = applying.objectForKey("entering_class_stats") as! NSDictionary
                
                
                
                //_selectivity
                let _selectivity = entering_class_stats.objectForKey("selectivity") as! NSDictionary
                
                let selectivity_selectivity = _selectivity.objectForKey("selectivity") as! String
                let acceptance_rate_acceptance_rate = _selectivity.objectForKey("acceptance_rate") as! String
                let early_decision_acceptance_rate = _selectivity.objectForKey("early_decision_acceptance_rate") as! String
                let early_action_acceptance_rate = _selectivity.objectForKey("early_action_acceptance_rate") as! String
                let acceptance_rate_wo_early_decision = _selectivity.objectForKey("acceptance_rate_wo_early_decision") as! String
                
                
                
                
                
                
                
                //applications_acceptance_enrollments
                let applications_acceptance_enrollments = entering_class_stats.objectForKey("applications_acceptance_enrollments") as! NSDictionary
                
                let applicants = applications_acceptance_enrollments.objectForKey("applicants") as! String
                let female_applicants = applications_acceptance_enrollments.objectForKey("female_applicants") as! String
                let male_applicants = applications_acceptance_enrollments.objectForKey("male_applicants") as! String
                let applicants_accepted = applications_acceptance_enrollments.objectForKey("applicants_accepted") as! String
                let female_applicants_accepted = applications_acceptance_enrollments.objectForKey("female_applicants_accepted") as! String
                let male_applicants_accepted = applications_acceptance_enrollments.objectForKey("male_applicants_accepted") as! String
                let freshman_enrollment = applications_acceptance_enrollments.objectForKey("freshman_enrollment") as! String
                
                
                
                
                
                //wait_list
                let wait_list = entering_class_stats.objectForKey("wait_list") as! NSDictionary
                
                let school_has_a_wait_list = wait_list.objectForKey("school_has_a_wait_list") as! String
                let applicants_placed_on_wait_list = wait_list.objectForKey("applicants_placed_on_wait_list") as! String
                let students_accepting_place_on_wait_list = wait_list.objectForKey("students_accepting_place_on_wait_list") as! String
                let students_accepted_from_wait_list = wait_list.objectForKey("students_accepted_from_wait_list") as! String
                
                
                
                let collegeApplying = CollegeApplying(application_deadline: _application_deadline, priority_application_deadline: priority_application_deadline, notification_date: notification_date, deadline_for_accepting_admission_offers: deadline_for_accepting_admission_offers, students_accepted_for_terms_other_than_the_fall: students_accepted_for_terms_other_than_the_fall, early_decision_plan_offered: early_decision_plan_offered, early_decision_deadline: early_decision_deadline, early_decision_sent_by: early_decision_sent_by, early_action_plan_offered: early_action_plan_offered, students_restricted_from_applying_to_other_early_action_plans: students_restricted_from_applying_to_other_early_action_plans, early_action_deadline: early_action_deadline, early_action_decision_sent_by: early_action_decision_sent_by, application_fee: _application_fee, application_fee_refundable: application_fee_refundable, application_fee_waived_for_stdents_with_financial_need: application_fee_waived_for_stdents_with_financial_need, application_fee_for_students_who_apply_online: application_fee_for_students_who_apply_online, deferred_admission_allowed: deferred_admission_allowed, maximum_length_of_determent: maximum_length_of_determent, application_url: application_url, common_application_accepted: common_application_accepted, tuition_deposit: tuition_deposit, tuition_deposit_refundable: tuition_deposit_refundable, room_deposit: room_deposit, room_deposit_refundable: room_deposit_refundable, admission_phone: admission_phone, admission_email: admission_email, admission_address: admission_address, admission_interview: admission_interview, campus_visit: campus_visit, offcampus_interviews: offcampus_interviews, open_admission_policy: open_admission_policy, college_use_SAT_or_ACT_in_admission_decisions: college_use_SAT_or_ACT_in_admission_decisions, required_standardized_tests: required_standardized_tests, ACT_with_writing_test: ACT_with_writing_test, SAT_ACT_scores_must_be_received_by: _SAT_ACT_scores_must_be_received_by, SAT_subject_test_scores_must_be_received_by: SAT_subject_test_scores_must_be_received_by, rigor_of_secondary_school_record: rigor_of_secondary_school_record, class_rank: class_rank, GPA: GPA, standardized_test_scores: standardized_test_scores, application_essay: application_essay, recommendations: recommendations, SAT_subject_tests: SAT_subject_tests, interview: interview, extracurricular_activities: extracurricular_activities, talent_ability: talent_ability, character_personal_qualities: character_personal_qualities, first_generation_college_student: first_generation_college_student, alumni_relations: alumni_relations, geographical_residence: geographical_residence, state_residency: state_residency, religious_affiliation: _religious_affiliation, race_ethnicity: race_ethnicity, volunteer_work: volunteer_work, work_experience: work_experience, applicants_interest_level: applicants_interest_level, selectivity: selectivity_selectivity, acceptance_rate: acceptance_rate, early_decision_acceptance_rate: early_decision_acceptance_rate, early_action_acceptance_rate: early_action_acceptance_rate, acceptance_rate_wo_early_decision: acceptance_rate_wo_early_decision, applicants: applicants, female_applicants: female_applicants, male_applicants: male_applicants, applicants_accepted: applicants_accepted, female_applicants_accepted: female_applicants_accepted, male_applicants_accepted: male_applicants_accepted, freshman_enrollment: freshman_enrollment, school_has_a_wait_list: school_has_a_wait_list, applicants_placed_on_wait_list: applicants_placed_on_wait_list, students_accepting_place_on_wait_list: students_accepting_place_on_wait_list, students_accepted_from_wait_list: students_accepted_from_wait_list)
                
                //-------------------------------------------------------------------------------------------------------------
                //academic
                //faculty_and_classes
                let faculty_and_classes = academic.objectForKey("faculty_and_classes") as! NSDictionary
                
                
                let student_faculty_ratio = faculty_and_classes.objectForKey("student_faculty_ratio") as! String
                let total_faculty = faculty_and_classes.objectForKey("total_faculty") as! String
                let minority = faculty_and_classes.objectForKey("minority") as! String
                let international = faculty_and_classes.objectForKey("international") as! String
                let full_time_faculty_with_phd_or_terminal_degree = faculty_and_classes.objectForKey("full_time_faculty_with_phd_or_terminal_degree") as! String
                let classes_taught_by_graduate_assistants = faculty_and_classes.objectForKey("classes_taught_by_graduate_assistants") as! String
                
                
                
                
                
                
                
                //majors
                let majors = academic.objectForKey("majors") as! NSDictionary
                //five_most_popular_majors
                let five_most_popular_majors_ofMajors = majors.objectForKey("five_most_popular_majors") as! NSDictionary
                //all_majors
                let all_majors = majors.objectForKey("all_majors") as! NSArray
                
                //academic_programs
                let academic_programs = academic.objectForKey("academic_programs") as! NSDictionary
                
                let degrees_offered = academic_programs.objectForKey("degrees_offered") as! String
                let qualified_undergraduate_may_take_graduate_classes = academic_programs.objectForKey("qualified_undergraduate_may_take_graduate_classes") as! String
                let preprofessional_programs = academic_programs.objectForKey("preprofessional_programs") as! String
                let teacher_certification_offered_in = academic_programs.objectForKey("teacher_certification_offered_in") as! String
                let subject_areas_offering_education_certification = academic_programs.objectForKey("subject_areas_offering_education_certification") as! String
                let student_exchange_programs_offered_with = academic_programs.objectForKey("student_exchange_programs_offered_with") as! String
                
                
                
                
                //graduation_and_retention
                let graduation_and_retention = academic.objectForKey("graduation_and_retention") as! NSDictionary
                
                let average_freshman_retention_rate_OfGraduationAndRetention = graduation_and_retention.objectForKey("average_freshman_retention_rate") as! String
                let six_year_graduation_rate_OfGraduationAndRetention = graduation_and_retention.objectForKey("six_year_graduation_rate") as! String
                let bachelors_degrees_awarded = graduation_and_retention.objectForKey("bachelors_degrees_awarded") as! String
                let masters_degrees_awarded_OfGraduationAndRetention = graduation_and_retention.objectForKey("masters_degrees_awarded") as! String
                let doctoral_degrees_research = graduation_and_retention.objectForKey("doctoral_degrees_research") as! String
                let pursued_further_study_immediately_after_graduation = graduation_and_retention.objectForKey("pursued_further_study_immediately_after_graduation") as! String
                let pursued_further_study_in_law = graduation_and_retention.objectForKey("pursued_further_study_in_law") as! String
                let pursued_further_study_in_medicine = graduation_and_retention.objectForKey("pursued_further_study_in_medicine") as! String
                
                
                
                
                let collegeAcademic = CollegeAcademic(student_faculty_ratio: student_faculty_ratio, total_faculty: total_faculty, minority: minority, international: international, full_time_faculty_with_phd_or_terminal_degree: full_time_faculty_with_phd_or_terminal_degree, classes_taught_by_graduate_assistants: classes_taught_by_graduate_assistants, five_most_popular_majors: five_most_popular_majors_ofMajors, all_majors: all_majors, degrees_offered: degrees_offered, qualified_undergraduate_may_take_graduate_classes: qualified_undergraduate_may_take_graduate_classes, preprofessional_programs: preprofessional_programs, teacher_certification_offered_in: teacher_certification_offered_in, subject_areas_offering_education_certification: subject_areas_offering_education_certification, student_exchange_programs_offered_with: student_exchange_programs_offered_with, average_freshman_retention_rate: average_freshman_retention_rate, six_year_graduation_rate: six_year_graduation_rate, bachelors_degrees_awarded: bachelors_degrees_awarded, masters_degrees_awarded: masters_degrees_awarded_OfGraduationAndRetention, doctoral_degrees_research: doctoral_degrees_research, pursued_further_study_immediately_after_graduation: pursued_further_study_immediately_after_graduation, pursued_further_study_in_law: pursued_further_study_in_law, pursued_further_study_in_medicine: pursued_further_study_in_medicine)
                
                
                
                //-------------------------------------------------------------------------------------------------------------
                //financial
                
                
                let tuition_and_fees_OfFinancial = financial.objectForKey("tuition_and_fees") as! String
                let room_and_board_OfFinancial = financial.objectForKey("room_and_board") as! String
                let estimated_cost_of_books_and_supplies = financial.objectForKey("estimated_cost_of_books_and_supplies") as! String
                let estimated_personal_expenses = financial.objectForKey("estimated_personal_expenses") as! String
                let average_need_based_scholarship = financial.objectForKey("average_need_based_scholarship") as! String
                let students_who_received_need_based_scholarship = financial.objectForKey("students_who_received_need_based_scholarship") as! String
                
                
                
                let collegeFinancial = CollegeFinancial(tuition_and_fees: tuition_and_fees_OfFinancial, room_and_board: room_and_board_OfFinancial, estimated_cost_of_books_and_supplies: estimated_cost_of_books_and_supplies, estimated_personal_expenses: estimated_personal_expenses, average_need_based_scholarship: average_need_based_scholarship, students_who_received_need_based_scholarship: students_who_received_need_based_scholarship)
                
                let collegeDetail = CollegeDetail(college: college, collegeOverview: collegeOverview, collegeRanking: collegeRanking, collegeApplying: collegeApplying, collegeAcademic: collegeAcademic, collegeFinancial: collegeFinancial)
                NSNotificationCenter.defaultCenter().postNotificationName("getCollegeDetailSuccessed", object: nil, userInfo: ["collegeDetail":collegeDetail])
                
                
            }
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getCollegeDetailFailed", object: nil)
                print("getCollegeDetail failure\n")
                print(error)
        }
        
        
    }
    
    static func signup(username:String,password:String,email:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",username,"name",password,"password",email,"email")
        print(userInfo)
        manager.POST(ServerConstant.signup, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("signupSuccessed", object: nil)
            print("signup success\n")
            print(response)
            
            print(response)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("signupFailed", object: nil)
                print("signup failure\n")
                print(error)
        }
        
    }
    
    
    
    static func getAllUsers(token:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        manager.GET(ServerConstant.get_user, parameters: nil, success: { (operation:AFHTTPRequestOperation!, respose:AnyObject!) -> Void in
            print("getAllUsers success\n")
            print(respose)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("getAllUsers failure\n")
        }
    }
    
    
    static func getCorrectBreakPoint(from:String,to:String)->String{
        return ServerConstant.get_college + from + "&num=" + to
    }
    
    static func getCorrectBreakPointForCollegeDetail(schoolId:String)->String {
        return ServerConstant.get_college_detail + schoolId
    }
    
    static func getCollege(from:String,to:String)->[College]{
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        var result : [College] = []
        manager.GET(getCorrectBreakPoint(from, to: to), parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            print("getCollege success\n")
            
            for school in response as! NSArray {
                let id = school.objectForKey("_id") as! String
                let name = school.objectForKey("name") as! String
                let general = school.objectForKey("general") as! NSDictionary
                
                
                let website = general.objectForKey("website") as! String
                let logo = general.objectForKey("logo") as! String
                
                let address = general.objectForKey("address") as! NSDictionary
                let photos = general.objectForKey("photos") as! [String]
                
                let city = address.objectForKey("city") as! String
                let country = address.objectForKey("country") as! String
                let state = address.objectForKey("state") as! String
                let zipcode = address.objectForKey("zipcode") as! String
                
                let college = College(id: id, name: name, city: city, state: state, country: country, zipcode: zipcode, website: website, logo: logo, photos: photos)
                result.append(college)
                //print(college)
                
            }
            /* 一次性保存20个college做cache
            // full path for local file data.plist
            let documentDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            let path = documentDir.stringByAppendingPathComponent("data.plist")
            let data : NSArray = response as! NSArray
            
            data.writeToFile(path, atomically: true)
            
            */
            
            
            
            /* 
            //下载20个college的图片
            let documentDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            var final : NSMutableDictionary = NSMutableDictionary()
            for school in result {
                
                let logoPath = documentDir.stringByAppendingPathComponent(school.name + " logo.jpg")
                if let image_url = NSURL(string: ServerConstant.baseURL + school.logo) {
                    if let image_data = NSData(contentsOfURL:image_url) {
                        if let image = UIImage(data: image_data) {
                            UIImageJPEGRepresentation(image, 100).writeToFile(logoPath, atomically: true)
                        }

                    }
                    
                    
                }
               
                
                var counter = 1
                    for photo in school.photos {
                        if let photo_url = NSURL(string: ServerConstant.baseURL + photo) {
                            if let photo_data = NSData(contentsOfURL: photo_url) {
                                if let photo_itself = UIImage(data: photo_data) {
                                    let photo_path = documentDir.stringByAppendingPathComponent(school.name + " photo.jpg" + counter.description)
                                    counter++
                                    UIImageJPEGRepresentation(photo_itself, 100).writeToFile(photo_path, atomically: true)
                                }
                            }
                            

                        }
                }
            }
            */

            
            NSNotificationCenter.defaultCenter().postNotificationName("getCollegeSuccessed", object: result)
            
            
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getCollegeFailed", object: nil)
                print("getCollege failure\n")
                print(error)
                
        }
        
        
        
        
        return result
        
    }
    
    static func obtainNewToken(refresh_token:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",refresh_token,"refresh_token")
        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("obtainNewTokenSuccessed", object: nil)
            
            print("obtainNewToken success\n")
            let dic = response as! NSDictionary
            let refresh_token = dic.objectForKey("refresh_token") as! String
            let token = dic.objectForKey("token") as! String
            
            
            NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
            NSUserDefaults.standardUserDefaults().setObject(refresh_token, forKey: "refresh_token")
            
            
            
            
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("obtainNewTokenFailed", object: nil)
                print("obtainNewToken failure\n")
                print(error)
        }
    }
    
    static func obtainToken(email:String,password:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",email,"email",password,"password")
        
        
        
        
        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            NSNotificationCenter.defaultCenter().postNotificationName("loginSuccessed", object: nil)
            print("login success\n")
            
            //print(response)
            let dic = response as! NSDictionary
            let refresh_token = dic.objectForKey("refresh_token") as! String
            let token = dic.objectForKey("token") as! String
            
            
            NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
            NSUserDefaults.standardUserDefaults().setObject(refresh_token, forKey: "refresh_token")
            
            
            
            
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("loginFailed", object: nil)
                print("login failure\n")
                print(error)
        }
        
    }
    
    static func getCourseOverview(courseName:String!)
    {
        
        Tool.showProgressHUD("正在获取课程")
        
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        var result : [CourseOverView] = []
        
        var url = ServerConstant.get_course_overview
        url += courseName
        
        manager.GET(url, parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            print("getCourseOverview success\n")
            
            for course in response as! NSArray {
                let _id = course.objectForKey("_id") as! String
                let name = course.objectForKey("name") as! String
                let overview = course.objectForKey("overview") as! NSDictionary
                
                
                let location = overview.objectForKey("location") as! String
                let favNum = overview.objectForKey("favs") as! NSInteger
                
                let teacherProfile = overview.objectForKey("teacher") as! NSDictionary
                
                let teacherName = teacherProfile.objectForKey("name") as! String
                let teacherPicURL = ServerConstant.baseURL + (teacherProfile.objectForKey("avatar") as! String)
                
                let photos = overview.objectForKey("photos") as! NSArray
                let coursePicURL = ServerConstant.baseURL + (photos[0] as! String)
                
                
                let metadata = course.objectForKey("metadata") as! NSDictionary
                let price = metadata.objectForKey("price") as! NSInteger
                
                
                let courseOverView = CourseOverView(_id: _id, metadata: metadata ,overview:overview,courseName: name, coursePicURL: coursePicURL, teacherPicURL: teacherPicURL, teacherName: teacherName, location: location, favNum: favNum, price: price)
                
                result.append(courseOverView)
                //print(college)
                
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName("didGetCourseOverview", object: result)
            
            //{"_id":"55a7190b452c74914dd42a85","name":"北京李湘TOEFL写作班","overview":{"category":"TOEFL","subtitle":"写作课程和一对一咨询","location":"北京 海淀区","introduction":"李湘老师曾获得美国芝加哥大学教育博士学位，她已经提供了3年的TOEFL写作课程，80%的学生获得95%以上的高分。写作班每周一次4小时，讲解和联系相结合，使学生的写作在12次的课次中有显著的提高。该课程从每个季度开始。","level":"400","favs":3569,"teacher":{"name":"李湘","avatar":"/public/img/avatar.lixiang.png"},"photos":["/public/img/course1.1.png","/public/img/course1.2.png","/public/img/course1.3.png"]},"metadata":{"favs":3569,"category":"TOEFL","subcategory":"写作","level":400,"price":899}}
            
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                print("getCourseOverview failure\n")
                print(error)
        }
    }
    
    
    static func getCourseDetail(courseID:String!)
    {
        Tool.showProgressHUD("正在获取课程详情")
        
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
    
        var url = ServerConstant.get_course_detail
        url += courseID
        
        manager.GET(url, parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            print("getCourseDetail success\n")
            
            let resDic = response as! NSDictionary
            
            let id = resDic.objectForKey("_id") as! String
            let courseName = resDic.objectForKey("name") as! String
            let sessions = resDic.objectForKey("sessions") as! NSArray
            
            
            let result = CourseDetail(_id: id, name: courseName, sessions: sessions)
            
            NSNotificationCenter.defaultCenter().postNotificationName("didGetCourseDetail", object: result)
            
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                print("getCourseDetail failure\n")
                print(error)
        }

        
        
    }
    
    
    
    
}






struct ServerConstant {
    
    static let baseURL = "https://livebo.cloudapp.net"
    static let client_id = "c050c2c1-3ac0-46c7-abf6-e7edfb16aee4"
    static let signup = "https://livebo.cloudapp.net/api/auth/signup"
    static let obtain_token = "https://livebo.cloudapp.net/api/auth/token"
    static let get_user = "https://livebo.cloudapp.net/api/users"
    static let get_college = "https://livebo.cloudapp.net/api/colleges?ranking="
    static let get_college_detail = "https://livebo.cloudapp.net/api/colleges/"
    static let user_profile = "https://livebo.cloudapp.net/api/profile"
    static let get_course_overview = "https://livebo.cloudapp.net/api/courses?category="
    static let get_course_detail = "https://livebo.cloudapp.net/api/courses/"
    
}




struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}



