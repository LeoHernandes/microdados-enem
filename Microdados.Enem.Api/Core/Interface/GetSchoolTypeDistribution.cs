namespace Core.Interface
{
    public record GetSchoolTypeDistribution(
        int UnknownCount,
        int PublicCount,
        int PrivateCount
     );
}
