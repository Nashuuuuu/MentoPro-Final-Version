package model;
public class Student {
    private int studentID;
    private String studentName, studentPhone, studentRole, studentEmail, studentUsername, studentPassword, courseCode, studentBio, studentAchievements, profilePic;
    private double studentCGPA;
    // Getters and Setters
    public int getStudentID() { return studentID; }
    public void setStudentID(int studentID) { this.studentID = studentID; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getStudentRole() { return studentRole; }
    public void setStudentRole(String studentRole) { this.studentRole = studentRole; }
    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }
    public String getProfilePic() { return profilePic; }
    public void setProfilePic(String profilePic) { this.profilePic = profilePic; }
    public String getStudentBio() { return studentBio; }
    public void setStudentBio(String studentBio) { this.studentBio = studentBio; }
    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    public String getStudentPhone() { return studentPhone; }
    public void setStudentPhone(String studentPhone) { this.studentPhone = studentPhone; }
    public String getStudentUsername() { return studentUsername; }
    public void setStudentUsername(String studentUsername) { this.studentUsername = studentUsername; }
    public String getStudentPassword() { return studentPassword; }
    public void setStudentPassword(String studentPassword) { this.studentPassword = studentPassword; }
    public double getStudentCGPA() { return studentCGPA; }
    public void setStudentCGPA(double studentCGPA) { this.studentCGPA = studentCGPA; }
    public String getStudentAchievements() { return studentAchievements; }
    public void setStudentAchievements(String studentAchievements) { this.studentAchievements = studentAchievements; }
}