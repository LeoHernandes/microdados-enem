namespace Core.Interface
{
    public record GetScoreDistributionBySchoolTypeResponse(
        Dictionary<int, int> PublicSchoolDistribution,
        Dictionary<int, int> PrivateSchoolDistribution
     );
}