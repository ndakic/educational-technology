package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KnowledgeSpaceGraphResource {
    private List<ProblemResource> problems;
    private List<LinkResource> links;

    @Getter
    @Setter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class KnowledgeSpaceGraphResponse {
        private Integer[] implications;
    }
}
