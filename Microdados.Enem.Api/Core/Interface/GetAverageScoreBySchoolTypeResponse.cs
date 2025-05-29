namespace Core.Interface
{
    public record GetAverageScoreBySchoolTypeResponse(
        Scores PublicSchoolScores,
        Scores PrivateSchoolScores
     );

    public record Scores(
        float AverageCH,
        float AverageCN,
        float AverageLC,
        float AverageMT,
        float AverageEssay
    );
}
