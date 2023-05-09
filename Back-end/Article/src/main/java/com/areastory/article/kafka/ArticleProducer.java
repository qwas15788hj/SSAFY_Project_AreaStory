package com.areastory.article.kafka;

import com.areastory.article.db.entity.Article;
import com.areastory.article.dto.common.ArticleKafkaDto;
import lombok.RequiredArgsConstructor;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ArticleProducer {
    private final KafkaTemplate<Long, ArticleKafkaDto> articleTemplate;

    public void send(Article article, String type) {
        ArticleKafkaDto articleKafkaDto = ArticleKafkaDto.builder()
                .type(type)
                .articleId(article.getArticleId())
                .userId(article.getUser().getUserId())
                .content(article.getContent())
                .image(article.getImage())
                .dailyLikeCount(article.getDailyLikeCount())
                .commentCount(article.getCommentCount())
                .createdAt(article.getCreatedAt())
                .dosi(article.getDosi())
                .sigungu(article.getSigungu())
                .dongeupmyeon(article.getDongeupmyeon())
                .build();
        articleTemplate.send(new ProducerRecord<>(KafkaProperties.TOPIC_ARTICLE, article.getUser().getUserId(), articleKafkaDto));
    }
}