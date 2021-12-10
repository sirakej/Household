
/// This variable holds the value of the API base url
/// const String BASE_URL = "https://householdexecutives.herokuapp.com/v1/";
const String BASE_URL = "https://backend.householdexecutivesltd.com/v1/";

/// Endpoints regarding user and their details
const SIGN_UP_URL = BASE_URL + "user/register";
const LOGIN_URL = BASE_URL + "user/login";
const RESET_PASSWORD_URL = BASE_URL + "user/resetpassword";
const CHANGE_PASSWORD = BASE_URL + "user/resetpassword/change";
const GET_USER = BASE_URL + "user";
const UPDATE_USER_PROFILE = BASE_URL + "user/profile";
const UPDATE_USER_PASSWORD = BASE_URL + "user/profile/password";

/// Endpoints to get banner details
const GET_AD_BANNER = BASE_URL + "banner";

const GET_SAVED_LIST = BASE_URL + "user/savedcandidate";
const UPDATE_CANDIDATE = BASE_URL + "user/purchase/savedcategory";
const GET_HIRED_CANDIDATES = BASE_URL + "user/hire";
const GET_SCHEDULED_CANDIDATES = BASE_URL + "user/schedule";

/// Endpoints regarding plan and payment
const GET_PLANS = BASE_URL + "plan";
const VERIFY_PAYMENT = BASE_URL + 'plan/payment/verify';
const FETCH_PAYMENT_HISTORY = BASE_URL + 'plan/payment/history';

/// Endpoints regarding categories and candidates
const GET_CATEGORY_URL = BASE_URL + "getcategory";
const CATEGORY_URL = BASE_URL + "category";
const POPULAR_CATEGORY = BASE_URL + "category/popular";
const CANDIDATE_URL = BASE_URL + "candidate";
const RECOMMENDED_CANDIDATE = BASE_URL + "candidate/recommended";
const SAVED_CANDIDATE = BASE_URL + 'candidate/saved';
const SCHEDULE_INTERVIEW = BASE_URL + "candidate/schedule";
const HIRE_CANDIDATE = BASE_URL + "candidate/hire";
const CANDIDTE_REVIEW = BASE_URL + 'candidate/review';
const SHOW_CANDIDATE_BUTTON = BASE_URL + 'candidate/toggle/';