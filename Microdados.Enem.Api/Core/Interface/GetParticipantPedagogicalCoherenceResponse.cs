namespace Core.Interface
{
    public record GetParticipantPedagogicalCoherenceResponse(
        string ExamColor,
        int RightAnswers,
        Dictionary<double, ItemHit> DifficultyRule
     );

    public record ItemHit(int Position, bool Hit);
}