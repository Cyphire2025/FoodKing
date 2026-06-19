<template>
    <LoadingComponent :props="loading" />
    <div v-if="bannerImage" class="banner-shell w-full">
        <img :src="bannerImage" alt="banner">
    </div>
</template>

<script>
import LoadingComponent from "../components/LoadingComponent";

export default {
    name: "SliderComponent",
    components: {
        LoadingComponent,
    },
    data() {
        return {
            loading: {
                isActive: false
            },
            bannerImage: '/storage/34/slide-0.jpg',
        }
    },
}
</script>
