namespace Core.Interface
{
    public record GetSchoolTypeDistributionResponse(
        int UnknownCount,
        int PublicCount,
        int PrivateCount
     );
}
