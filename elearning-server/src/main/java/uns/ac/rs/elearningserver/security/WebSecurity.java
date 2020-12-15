package uns.ac.rs.elearningserver.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class WebSecurity extends WebSecurityConfigurerAdapter {

    @Override
    public void configure(org.springframework.security.config.annotation.web.builders.WebSecurity web) {
        web
                .ignoring()
                .antMatchers("/static/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().and().csrf().disable().authorizeRequests()
                .antMatchers(HttpMethod.GET, "/question/**").permitAll()
                .antMatchers(HttpMethod.POST, "/question/**").permitAll()
                .antMatchers(HttpMethod.GET, "/test/**").permitAll()
                .antMatchers(HttpMethod.POST, "/test/**").permitAll()
                .antMatchers(HttpMethod.GET, "/answer/**").permitAll()
                .antMatchers(HttpMethod.POST, "/answer/**").permitAll()
                .antMatchers(HttpMethod.GET, "/link/**").permitAll()
                .antMatchers(HttpMethod.POST, "/link/**").permitAll()
                .antMatchers(HttpMethod.GET, "/problem/**").permitAll()
                .antMatchers(HttpMethod.POST, "/problem/**").permitAll()
                .antMatchers(HttpMethod.GET, "/domain/**").permitAll()
                .antMatchers(HttpMethod.POST, "/domain/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
    }

    @Bean
    public org.springframework.web.filter.CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(false);
        config.addAllowedOrigin("*");
        config.addAllowedHeader("*");
        config.addAllowedOriginPattern("*");
        config.setExposedHeaders(Arrays.asList("Access-Control-Allow-Origin", "Location", "X-Requested-With", "Authorization", "Cache-Control", "Content-Type", "X-Total-Count", "allowedOriginPatterns"));
        config.addAllowedMethod(HttpMethod.OPTIONS.name());
        config.addAllowedMethod(HttpMethod.GET.name());
        config.addAllowedMethod(HttpMethod.PUT.name());
        config.addAllowedMethod(HttpMethod.POST.name());
        config.addAllowedMethod(HttpMethod.DELETE.name());
        source.registerCorsConfiguration("/**", config);
        return new org.springframework.web.filter.CorsFilter(source);
    }
}
