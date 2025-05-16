namespace Core.Interface
{
    public record GetDifficultyDistributionResponse(
        string Color,
        QuestionDifficulty EasiestQuestion,
        QuestionDifficulty HardestQuestion,
        Dictionary<int, double?> Distribution
     );

    public record QuestionDifficulty(int Position, double? Difficulty);
}
