public class Major 
{
 private String NameMajor;
 private int Enrollment;

 public Major(String name, int enrollment) 
 {
   this.NameMajor = name;
   this.Enrollment = enrollment;
 } 
 
 public String getName() {
   return NameMajor;
 }
 
 public int getEnrollment() {
    return Enrollment; 
 }
}
