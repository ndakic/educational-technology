package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
public class KnowledgeSpaceGraphResource {
    private List<ProblemResource> problems;
    private List<LinkResource> links;
    private Double graphSimilarityPercent;

    public KnowledgeSpaceGraphResource() {
        this.problems = new ArrayList<>();
        this.links = new ArrayList<>();
        this.graphSimilarityPercent = null;
    }

    @Getter
    @Setter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class KnowledgeSpaceGraphResponse {
        private Integer[] implications;
    }
}
