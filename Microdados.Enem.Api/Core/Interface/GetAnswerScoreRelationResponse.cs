namespace Core.Interface
{
    public record GetAnswerScoreRelationResponse(
        float MinScore,
        float MaxScore,
        Dictionary<int, int> Histogram
     );
}